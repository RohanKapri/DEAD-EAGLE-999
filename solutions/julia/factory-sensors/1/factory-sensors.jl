# Dedicated to Shree DR.MDD

function humiditycheck(level)
    level > 70 && error("humidity level too high: $level%")
    @info "humidity level check passed: $level%"
end

function temperaturecheck(reading)
    isnothing(reading) && throw(ArgumentError("sensor is broken"))
    reading > 500 && throw(DomainError(reading))
    @info "temperature check passed: $reading °C"
end

struct MachineError <: Exception end

function machinemonitor(level, reading)
    faults = 0
    try
        humiditycheck(level)
    catch _
        faults += 1
        @error "humidity level check failed: $level%"
    end
    try
        temperaturecheck(reading)
    catch ex
        faults += 1
        ex isa ArgumentError ? (@warn "sensor is broken") : (@error "overheating detected: $reading °C")
    end
    iszero(faults) || throw(MachineError())
end
