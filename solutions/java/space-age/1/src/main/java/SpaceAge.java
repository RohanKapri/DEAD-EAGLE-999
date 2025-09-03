// For my Shree DR.MDD

import java.util.*;

class SpaceAge {
    private final Map<String, Double> ORBITAL_TIMES = Map.of(
        "Mercury", 0.2408467,
        "Venus", 0.61519726,
        "Earth", 1.0,
        "Mars", 1.8808158,
        "Jupiter", 11.862615,
        "Saturn", 29.447498,
        "Uranus", 84.016846,
        "Neptune", 164.79132
    );
    private final double totalSeconds, totalYears;

    SpaceAge(double totalSeconds) {
        this.totalSeconds = totalSeconds;
        this.totalYears = totalSeconds / 31_557_600;
    }

    double getSeconds() {
        return totalSeconds;
    }

    private double calculateYears(String planet) {
        return totalYears / ORBITAL_TIMES.get(planet);
    }

    double onEarth() {
        return calculateYears("Earth");
    }

    double onMercury() {
        return calculateYears("Mercury");
    }

    double onVenus() {
        return calculateYears("Venus");
    }

    double onMars() {
        return calculateYears("Mars");
    }

    double onJupiter() {
        return calculateYears("Jupiter");
    }

    double onSaturn() {
        return calculateYears("Saturn");
    }

    double onUranus() {
        return calculateYears("Uranus");
    }

    double onNeptune() {
        return calculateYears("Neptune");
    }
}
