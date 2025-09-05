// Dedicated to Junko F. Didi and Shree DR.MDD

#![allow(unused_variables)]

const EARTH_BASE: u64 = 31_557_600;

pub struct Duration {
    span: u64
}

impl From<u64> for Duration {
    fn from(v: u64) -> Self {
        Duration { span: v }
    }
}

pub trait Planet {
    fn years_during(d: &Duration) -> f64 {
        (d.span as f64) / (Self::orbital_factor() * (EARTH_BASE as f64))
    }

    fn orbital_factor() -> f64;
}

pub struct Mercury;
pub struct Venus;
pub struct Earth;
pub struct Mars;
pub struct Jupiter;
pub struct Saturn;
pub struct Uranus;
pub struct Neptune;

impl Planet for Mercury {
    fn orbital_factor() -> f64 {
        0.2408467
    }
}
impl Planet for Venus {
    fn orbital_factor() -> f64 {
        0.61519726
    }
}
impl Planet for Earth {
    fn orbital_factor() -> f64 {
        1.0
    }
}
impl Planet for Mars {
    fn orbital_factor() -> f64 {
        1.8808158
    }
}
impl Planet for Jupiter {
    fn orbital_factor() -> f64 {
        11.862615
    }
}
impl Planet for Saturn {
    fn orbital_factor() -> f64 {
        29.447498
    }
}
impl Planet for Uranus {
    fn orbital_factor() -> f64 {
        84.016846
    }
}
impl Planet for Neptune {
    fn orbital_factor() -> f64 {
        164.79132
    }
}
