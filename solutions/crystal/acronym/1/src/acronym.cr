# Please implement your solution to acronym in this file

class Acronym
    def self.abbreviate(s)
        s.split(/[ _-]+/).join(&.[0].upcase)
    end
end