using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using System.Reactive;
using System.Reactive.Linq;
using System.Reactive.Subjects;

public class HangmanState
{
    public string MaskedWord { get; }
    public ImmutableHashSet<char> GuessedChars { get; }
    public int RemainingGuesses { get; }

    public HangmanState(string maskedWord, ImmutableHashSet<char> guessedChars, int remainingGuesses)
    {
        MaskedWord = maskedWord;
        GuessedChars = guessedChars;
        RemainingGuesses = remainingGuesses;
    }
}
public class TooManyGuessesException : Exception
{
}
public class Hangman
{
    public IObservable<HangmanState> StateObservable { get; }
    public IObserver<char> GuessObserver { get; }
    private HashSet<char> guessedChars;
    private const int MaxRemainingGuesses = 9;
    public Hangman(string word)
    {
        guessedChars =  new HashSet<char>();
        HangmanState status = new HangmanState(new String('_', word.Length), guessedChars.ToImmutableHashSet(), MaxRemainingGuesses );
        var stateSubject = new BehaviorSubject<HangmanState>(status);
        StateObservable = stateSubject;        
        GuessObserver =  Observer.Create<char>(value => {
                        char[] guessed = stateSubject.Value.MaskedWord.ToString().ToArray();
                        HashSet<char> guessedChars = new HashSet<char>(stateSubject.Value.GuessedChars);
                        bool isHit = false;
                        if (stateSubject.Value.RemainingGuesses>=0) {
                            for(var ii=0; ii<word.Length; ii++) {
                                if (word[ii] == value) {
                                    if (!guessedChars.Contains(value)) isHit = true;
                                    guessed[ii] = word[ii];
                                    guessedChars.Add(value);
                                }
                            }
                            string maskedword = new string(guessed);
                            if (maskedword == word) 
                                stateSubject.OnCompleted();
                            else if (stateSubject.Value.RemainingGuesses < 1)
                                stateSubject.OnError(new  TooManyGuessesException() );
                            else {
                                stateSubject.OnNext(new HangmanState(maskedword, 
                                    guessedChars.ToImmutableHashSet(), (isHit) ? stateSubject.Value.RemainingGuesses : (stateSubject.Value.RemainingGuesses-1)));
                            }
                        }
            } 
        );          
    }
}