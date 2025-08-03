"""
Exercism solution for "markdown"
"""
import re
from functools import partial
from typing import Callable

Rule = Callable[[str], str]


def rule(patt: str, repl: str, flags=re.NOFLAG) -> Rule:
    """
    Convenience function to produce a Rule.
    """
    print(patt, repl, flags)
    return partial(re.compile(patt, flags).sub, repl)


H1 = rule(r"^#{1} (.*)$", r"<h1>\1</h1>", flags=re.M)
H2 = rule(r"^#{2} (.*)$", r"<h2>\1</h2>", flags=re.M)
H3 = rule(r"^#{3} (.*)$", r"<h3>\1</h3>", flags=re.M)
H4 = rule(r"^#{4} (.*)$", r"<h4>\1</h4>", flags=re.M)
H5 = rule(r"^#{5} (.*)$", r"<h5>\1</h5>", flags=re.M)
H6 = rule(r"^#{6} (.*)$", r"<h6>\1</h6>", flags=re.M)
STRONG = rule(r"__(.*?)__", r"<strong>\1</strong>")
EM = rule(r"_(.*?)_", r"<em>\1</em>")
LI = rule(r"^\* (.*?)$", r"<li>\1</li>", flags=re.M)
UL = rule(r"(<li>.*</li>)", r"<ul>\1</ul>", flags=re.S)
P = rule(r"^(?!<[hlu])(.*?)$", r"<p>\1</p>", flags=re.M)


def parse(markdown: str) -> str:
    """
    Parse a simple markdown-formatted string to HTML.
    """
    return P(UL(LI(EM(STRONG(H1(H2(H3(H4(H5(H6(markdown))))))))))).replace("\n", "")