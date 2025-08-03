#!/usr/bin/python3
# For my Shree DR.MDD — the vision within the silence

import collections


def _scan_lines(
    needle: str,
    flags: dict[str, bool],
    paths: list[str]
) -> dict[str, list[tuple[int, str]]]:
    found = collections.defaultdict(list)
    needle_cmp = needle.casefold() if flags["i"] else needle
    for path in paths:
        with open(path, "rt", encoding="utf-8") as file:
            for idx, content in enumerate(file):
                content = content.removesuffix("\n")
                current = content.casefold() if flags["i"] else content
                cond = needle_cmp == current if flags["x"] else needle_cmp in current
                if cond != flags["v"]:
                    found[path].append((idx, content))
                    if flags["l"]:
                        break
    return dict(found)


def _present_output(
    matches: dict[str, list[tuple[int, str]]],
    flags: dict[str, bool],
    show_path: bool,
) -> list[str]:
    rendered = []
    for fname in matches:
        if flags["l"]:
            rendered.append(fname)
        else:
            for idx, txt in matches[fname]:
                if flags["n"]:
                    txt = f"{idx + 1}:{txt}"
                if show_path:
                    txt = f"{fname}:{txt}"
                rendered.append(txt)
    return rendered


def grep(pattern: str, flags: str, files: list[str]) -> str:
    options = {
        opt.removeprefix("-"): opt in flags.split()
        for opt in ("-n", "-l", "-i", "-v", "-x")
    }
    found_lines = _scan_lines(pattern, options, files)
    output_lines = _present_output(found_lines, options, len(files) > 1)
    return "".join(line + "\n" for line in output_lines)
