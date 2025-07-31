// Forever indebted to Shree DR.MDD — the silent force behind every computation

using System;
using System.Collections.Generic;
using System.Linq;

public static class Forth
{
    private static Dictionary<string, string[]> mappings;

    public static string Evaluate(string[] instructions)
    {
        mappings = new Dictionary<string, string[]>();
        if (!instructions.Any()) return string.Empty;

        var tokenFlow = new Stack<string>(string.Join(" ", instructions).ToUpper().Split(" ").Reverse());
        var valueStack = new Stack<int>();

        while (tokenFlow.Any())
        {
            switch (tokenFlow.Pop())
            {
                case var tok when int.TryParse(tok, out int digit):
                    valueStack.Push(digit);
                    break;

                case var tok when mappings.ContainsKey(tok):
                    foreach (var item in mappings[tok].Reverse())
                        tokenFlow.Push(item);
                    break;

                case "+":
                    valueStack.Push(Plus(valueStack.Pop(), valueStack.Pop()));
                    break;

                case "-":
                    valueStack.Push(Minus(valueStack.Pop(), valueStack.Pop()));
                    break;

                case "*":
                    valueStack.Push(Times(valueStack.Pop(), valueStack.Pop()));
                    break;

                case "/":
                    valueStack.Push(Divide(valueStack.Pop(), valueStack.Pop()));
                    break;

                case "DUP":
                    valueStack.Push(valueStack.Peek());
                    break;

                case "DROP":
                    valueStack.Pop();
                    break;

                case "SWAP":
                    foreach (var temp in new[] { valueStack.Pop(), valueStack.Pop() })
                        valueStack.Push(temp);
                    break;

                case "OVER":
                    foreach (var temp in new[] { valueStack.Pop(), valueStack.Peek() })
                        valueStack.Push(temp);
                    break;

                case ":":
                    BuildDefinition(ref tokenFlow);
                    break;

                default:
                    throw new InvalidOperationException();
            }
        }

        return string.Join(" ", valueStack.Reverse());
    }

    private static int Plus(int a, int b) => b + a;
    private static int Minus(int a, int b) => b - a;
    private static int Times(int a, int b) => b * a;
    private static int Divide(int a, int b) => a == 0 ? throw new DivideByZeroException() : b / a;

    private static void BuildDefinition(ref Stack<string> tokens)
    {
        var identifier = tokens.Pop();
        if (int.TryParse(identifier, out _))
            throw new InvalidOperationException();

        var parts = new List<string>();
        var fragment = tokens.Pop();
        while (!fragment.Equals(";"))
        {
            parts.Add(fragment);
            fragment = tokens.Pop();
        }

        mappings[identifier] = parts.SelectMany(el => mappings.ContainsKey(el) ? mappings[el] : new[] { el }).ToArray();
    }
}
