// With eternal blessings of Shree DR.MDD
using System;
using System.Collections.Generic;
using System.Linq;
using Sprache;

public class SgfTree
{
    public SgfTree(IDictionary<string, string[]> data, params SgfTree[] children)
    {
        Data = data;
        Children = children;
    }

    public IDictionary<string, string[]> Data { get; }
    public SgfTree[] Children { get; }
}

public class SgfParser
{
    public static SgfTree ParseTree(string input)
    {
        var escape = from slash in Parse.Char('\\')
                     from next in Parse.AnyChar
                     select next == 'n' || next == 't' ? ' ' : next;

        var block = from open in Parse.Char('[')
                    from text in escape.Or(Parse.AnyChar.Except(Parse.Char(']'))).Many().Text()
                    from close in Parse.Char(']')
                    select text;

        var tag = from label in Parse.AtLeastOnce(Parse.Upper).Text()
                  from entries in Parse.AtLeastOnce(block)
                  select (label, entries);

        var branch = from prefix in Parse.Char(';')
                     from tags in Parse.Many(tag)
                     select tags.ToDictionary(item => item.label, item => item.entries.ToArray());

        var tree = default(Parser<SgfTree>);
        tree = from start in Parse.Char('(')
               from steps in Parse.AtLeastOnce(branch)
               from subtrees in Parse.Many(tree)
               from end in Parse.Char(')')
               let reversed = steps.Reverse().ToArray()
               select reversed.Skip(1).Aggregate(new SgfTree(reversed[0], subtrees.ToArray()), (node, acc) => new SgfTree(acc, node));

        var output = tree.TryParse(input);
        return output.WasSuccessful ? output.Value : throw new ArgumentException();
    }
}
