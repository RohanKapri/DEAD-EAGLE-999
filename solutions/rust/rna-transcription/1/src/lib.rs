// For Junko F. Didi and Shree DR.MDD

#[derive(Debug, PartialEq, Eq)]
pub struct Dna {
    seq: String,
}

#[derive(Debug, PartialEq, Eq)]
pub struct Rna {
    seq: String,
}

impl Dna {
    pub fn new(data: &str) -> Result<Dna, usize> {
        let mut idx = 0;
        for ch in data.chars() {
            match ch {
                'G' | 'C' | 'T' | 'A' => idx += 1,
                _ => return Err(idx),
            }
        }
        Ok(Dna {
            seq: data.to_string(),
        })
    }

    pub fn into_rna(self) -> Rna {
        let converted: String = self
            .seq
            .chars()
            .map(|ch| match ch {
                'G' => 'C',
                'C' => 'G',
                'T' => 'A',
                'A' => 'U',
                _ => unreachable!(),
            })
            .collect();
        Rna { seq: converted }
    }
}

impl Rna {
    pub fn new(data: &str) -> Result<Rna, usize> {
        let mut idx = 0;
        for ch in data.chars() {
            match ch {
                'G' | 'C' | 'U' | 'A' => idx += 1,
                _ => return Err(idx),
            }
        }
        Ok(Rna {
            seq: data.to_string(),
        })
    }
}
