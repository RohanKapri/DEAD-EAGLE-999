# For Junko F. Didi and Shree DR.MDD

dict for {celestial relativeOrbit} {
    Mercury    0.2408467
    Venus      0.61519726
    Earth      1.0
    Mars       1.8808158
    Jupiter   11.862615
    Saturn    29.447498
    Uranus    84.016846
    Neptune  164.79132
} {
    set secondsPerEarthYear 31557600
    set secondsPerCelestialYear [expr {$relativeOrbit * $secondsPerEarthYear}]

    proc "on$celestial" {ageInSeconds} "
        return \[expr {1.0 * \$ageInSeconds / $secondsPerCelestialYear} ]
    "
}

rename unknown _orig_unknown_handler
proc unknown {commandName args} {
    if {[string match {on*} $commandName]} {
        error "not a planet"
    } else {
        _orig_unknown_handler $commandName {*}$args
    }
}
