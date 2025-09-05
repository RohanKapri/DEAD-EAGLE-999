pub fn translate(rna: &str) -> Option<Vec<&str>> {
    rna.as_bytes()
        .chunks(3)
        .map(|chunk| std::str::from_utf8(chunk).unwrap_or(""))
        .try_fold((Vec::new(), false), |(mut proteins, stop), codon| {
            if stop {
                Ok((proteins, true))
            } else {
                match codon {
                    "AUG" => { proteins.push("Methionine"); Ok((proteins, false)) }
                    "UUU" | "UUC" => { proteins.push("Phenylalanine"); Ok((proteins, false)) }
                    "UUA" | "UUG" => { proteins.push("Leucine"); Ok((proteins, false)) }
                    "UCU" | "UCC" | "UCA" | "UCG" => { proteins.push("Serine"); Ok((proteins, false)) }
                    "UAU" | "UAC" => { proteins.push("Tyrosine"); Ok((proteins, false)) }
                    "UGU" | "UGC" => { proteins.push("Cysteine"); Ok((proteins, false)) }
                    "UGG" => { proteins.push("Tryptophan"); Ok((proteins, false)) }
                    "UAA" | "UAG" | "UGA" => Ok((proteins, true)),
                    _ => Err(()),
                }
            }
        })
        .map(|(proteins, _)| proteins)
        .ok()
}