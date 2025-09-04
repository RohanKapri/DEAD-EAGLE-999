using Dates
const dtfmt = dateformat"mm/dd/yyyy HH:MM:SS"
const apptfmt = dateformat"E, U d, yyyy at HH:MM"

schedule_appointment(appointment::String) = DateTime(appointment, dtfmt)

has_passed(appointment::DateTime) = now() > appointment

is_afternoon_appointment(appointment::DateTime) = 11 < hour(appointment) < 18

describe(dt::DateTime) = "You have an appointment on " * Dates.format(dt, apptfmt)

anniversary_date() = Date(year(now()), 9, 15)