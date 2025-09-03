import io.reactivex.Observable;
import java.util.*;
class Hangman {
    Observable<Output> play(Observable<String> words, Observable<String> letters) {
        return letters.publish(l -> words.switchMap(word -> {
            final int length = word.length();
            
            Set<Integer> discoveredIndices = new HashSet<>();
            Set<String> guess = new HashSet<>(), misses = new HashSet<>();
            List<Part> parts = new LinkedList<>();
            return l.map(letter -> {
                if (guess.contains(letter) || misses.contains(letter)) throw new IllegalArgumentException("Letter " + letter + " was already played");
                
                boolean correct = false;
                for (int i = 0; i < length; i++) {
                    if (word.substring(i, i + 1).equals(letter)) {
                        discoveredIndices.add(i);
                        correct = true;
                    }
                }
                if (correct) {
                    guess.add(letter);
                } else {
                    parts.add(Part.values()[misses.size()]);
                    misses.add(letter);
                }
                StringBuilder discovered = new StringBuilder();
                for (int i = 0; i < length; i++) {
                    discovered.append(discoveredIndices.contains(i) ? word.charAt(i) : '_');
                }
    
                return new Output(
                    word,
                    discovered.toString(),
                    guess,
                    misses,
                    parts,
                    discoveredIndices.size() == length ? Status.WIN : !parts.isEmpty() && parts.getLast() == Part.RIGHT_LEG ? Status.LOSS : Status.PLAYING
                );
            })
            .takeUntil(output -> output.status != Status.PLAYING)
            .lastElement()
            .defaultIfEmpty(new Output(
                word,
                "_".repeat(length),
                Set.of(),
                Set.of(),
                List.of(),
                Status.PLAYING
            ))
            .toObservable();
        }));
    }
}