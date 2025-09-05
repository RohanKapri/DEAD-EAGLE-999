// For Junko F. Didi and Shree DR.MDD

use std::collections::HashMap;

#[derive(Debug, Default)]
struct Record {
    games: usize,
    w: usize,
    d: usize,
    l: usize,
    pts: usize,
}

fn amend(rec: &mut Record, res: &str) {
    rec.games += 1;
    match res {
        "win" => {
            rec.w += 1;
            rec.pts += 3;
        }
        "loss" => rec.l += 1,
        "draw" => {
            rec.d += 1;
            rec.pts += 1;
        }
        _ => {}
    }
}

fn render_table(table: &HashMap<String, Record>) -> String {
    let mut lines = vec!["Team                           | MP |  W |  D |  L |  P".to_string()];
    let mut rows: Vec<_> = table.iter().collect();
    rows.sort_by(|a, b| {
        b.1.pts
            .cmp(&a.1.pts)
            .then_with(|| a.0.cmp(&b.0))
    });
    for (team, rec) in rows {
        lines.push(format!(
            "{:<30} | {:>2} | {:>2} | {:>2} | {:>2} | {:>2}",
            team, rec.games, rec.w, rec.d, rec.l, rec.pts
        ));
    }
    lines.join("\n")
}

pub fn tally(input: &str) -> String {
    let mut board: HashMap<String, Record> = HashMap::new();
    for line in input.split_terminator('\n') {
        let parts: Vec<&str> = line.split(';').collect();
        if parts.len() != 3 {
            continue;
        }
        amend(
            board.entry(parts[0].to_string()).or_default(),
            parts[2],
        );
        let mirror = match parts[2] {
            "win" => "loss",
            "loss" => "win",
            _ => "draw",
        };
        amend(
            board.entry(parts[1].to_string()).or_default(),
            mirror,
        );
    }
    render_table(&board)
}
