use std::fs;
use anyhow::Error;

const FLAG_N: &str = "-n";
const FLAG_L: &str = "-l";
const FLAG_I: &str = "-i";
const FLAG_V: &str = "-v";
const FLAG_X: &str = "-x";

#[derive(Debug)]
pub struct Flags {
    show_line_number: bool,
    file_name_only: bool,
    ignore_case: bool,
    invert_match: bool,
    full_line: bool,
}

impl Flags {
    pub fn new(raw: &[&str]) -> Self {
        Flags {
            show_line_number: raw.contains(&FLAG_N),
            file_name_only: raw.contains(&FLAG_L),
            ignore_case: raw.contains(&FLAG_I),
            invert_match: raw.contains(&FLAG_V),
            full_line: raw.contains(&FLAG_X),
        }
    }
}

fn prep_pat(p: &str, opts: &Flags) -> String {
    if opts.ignore_case { p.to_lowercase() } else { p.to_string() }
}

fn matches(p: &str, text: &str, opts: &Flags) -> bool {
    if opts.full_line {
        text == p
    } else {
        text.contains(p)
    }
}

fn prefix_file(files: &[&str], file: &str) -> String {
    if files.len() > 1 { format!("{}:", file) } else { String::new() }
}

fn prefix_line(opts: &Flags, idx: usize) -> String {
    if opts.show_line_number { format!("{}:", idx + 1) } else { String::new() }
}

fn read_file(file: &str) -> std::io::Result<String> {
    fs::read_to_string(file)
}

fn check_line(line: &str, opts: &Flags, pat: &str) -> Option<String> {
    if line.is_empty() { return None; }
    let cmp = if opts.ignore_case { line.to_lowercase() } else { line.to_string() };
    if matches(pat, &cmp, opts) != opts.invert_match {
        Some(line.to_string())
    } else {
        None
    }
}

fn format_res(opts: &Flags, file: &str, line: &str, idx: usize, files: &[&str]) -> String {
    if opts.file_name_only {
        file.to_string()
    } else {
        format!("{}{}{}", prefix_file(files, file), prefix_line(opts, idx), line)
    }
}

pub fn grep(p: &str, opts: &Flags, files: &[&str]) -> Result<Vec<String>, Error> {
    let mut results = Vec::new();
    let pat = prep_pat(p, opts);

    for file in files {
        let content = read_file(file)?;
        for (i, line) in content.split('\n').enumerate() {
            if let Some(l) = check_line(line, opts, &pat) {
                results.push(format_res(opts, file, &l, i, files));
                if opts.file_name_only { break; }
            }
        }
    }
    Ok(results)
}
