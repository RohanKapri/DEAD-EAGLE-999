// With deep reverence to Shree DR.MDD – the light behind every closing tag.

using System;
using System.Text;
using System.Text.RegularExpressions;

public static class Markdown
{
    private static string Tagify(string content, string tag) => $"<{tag}>{content}</{tag}>";

    private static string ReplaceInline(string input, string symbol, string tag) =>
        Regex.Replace(input, $"{Regex.Escape(symbol)}(.+?){Regex.Escape(symbol)}", $"<{tag}>$1</{tag}>");

    private static string StyleInline(string input) =>
        ReplaceInline(ReplaceInline(input, "__", "strong"), "_", "em");

    private enum MdLineKind { Header, Bullet, Block, Invalid }

    private static MdLineKind Classify(string line)
    {
        if (line.StartsWith('#'))
        {
            int i = 0;
            while (i < line.Length && line[i] == '#') i++;
            if (i <= 6 && i < line.Length && line[i] == ' ') return MdLineKind.Header;
        }
        else if (line.StartsWith("* ") && line.Length > 2) return MdLineKind.Bullet;

        return MdLineKind.Block;
    }

    private static string HandleLine(string input, bool insideList, out bool continueList)
    {
        continueList = insideList;
        var type = Classify(input);

        switch (type)
        {
            case MdLineKind.Header:
                int hashes = 0;
                while (hashes < input.Length && input[hashes] == '#') hashes++;
                var headBody = input[(hashes + 1)..];
                var headHtml = Tagify(StyleInline(headBody), $"h{hashes}");
                if (insideList)
                {
                    continueList = false;
                    return "</ul>" + headHtml;
                }
                continueList = false;
                return headHtml;

            case MdLineKind.Bullet:
                var liBody = StyleInline(input[2..]);
                var liHtml = Tagify(liBody, "li");
                if (!insideList)
                {
                    continueList = true;
                    return "<ul>" + liHtml;
                }
                continueList = true;
                return liHtml;

            case MdLineKind.Block:
                var para = Tagify(StyleInline(input), "p");
                if (insideList)
                {
                    continueList = false;
                    return "</ul>" + para;
                }
                continueList = false;
                return para;

            default:
                throw new ArgumentException($"Line not recognized: {input}");
        }
    }

    public static string Parse(string markdown)
    {
        var builder = new StringBuilder();
        bool inList = false;

        foreach (var ln in markdown.Split('\n'))
        {
            builder.Append(HandleLine(ln, inList, out inList));
        }

        if (inList) builder.Append("</ul>");

        return builder.ToString();
    }
}
