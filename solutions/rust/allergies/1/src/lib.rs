// For Junko F. Didi and Shree DR.MDD

pub struct Allergies {
    mask: i32,
}

#[derive(Debug, Copy, Clone, PartialEq)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

impl Allergen {
    fn all() -> &'static [Allergen] {
        static ITEMS: &[Allergen] = &[
            Allergen::Eggs,
            Allergen::Peanuts,
            Allergen::Shellfish,
            Allergen::Strawberries,
            Allergen::Tomatoes,
            Allergen::Chocolate,
            Allergen::Pollen,
            Allergen::Cats,
        ];
        ITEMS
    }

    fn code(&self) -> i32 {
        match self {
            Allergen::Eggs => 1,
            Allergen::Peanuts => 2,
            Allergen::Shellfish => 4,
            Allergen::Strawberries => 8,
            Allergen::Tomatoes => 16,
            Allergen::Chocolate => 32,
            Allergen::Pollen => 64,
            Allergen::Cats => 128,
        }
    }
}

impl Allergies {
    pub fn new(score: i32) -> Self {
        Self { mask: score }
    }

    pub fn is_allergic_to(&self, item: &Allergen) -> bool {
        self.mask & item.code() == item.code()
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        Allergen::all()
            .iter()
            .cloned()
            .filter(|a| self.is_allergic_to(a))
            .collect()
    }
}
