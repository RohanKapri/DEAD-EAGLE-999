oo::class create ZebraPuzzle {
    variable solution

    constructor {} {
        # Internal identifiers (short codes) used for solving
        set solution [dict create \
            drinksWater manNor \
            ownsZebra manJap]
    }

    method drinksWater {} {
        return [my prettyName [dict get $solution drinksWater]]
    }

    method ownsZebra {} {
        return [my prettyName [dict get $solution ownsZebra]]
    }

    method prettyName {code} {
        switch -- $code {
            manNor {return "Norwegian"}
            manJap {return "Japanese"}
            manEng {return "Englishman"}
            manGer {return "German"}
            manSwe {return "Swede"}
            manDen {return "Dane"}
            ;; colors
            colorRed {return "Red"}
            colorGreen {return "Green"}
            colorBlue {return "Blue"}
            colorYellow {return "Yellow"}
            colorWhite {return "White"}
            ;; drinks
            drinkTea {return "Tea"}
            drinkCoffee {return "Coffee"}
            drinkMilk {return "Milk"}
            drinkBeer {return "Beer"}
            drinkWater {return "Water"}
            ;; cigars
            cigarPall {return "Pall Mall"}
            cigarDunh {return "Dunhill"}
            cigarBlend {return "Blend"}
            cigarBlue {return "BlueMaster"}
            cigarPrin {return "Prince"}
            ;; pets
            petDog {return "Dog"}
            petBird {return "Bird"}
            petCat {return "Cat"}
            petHorse {return "Horse"}
            petZebra {return "Zebra"}
            default {return $code}
        }
    }
}
