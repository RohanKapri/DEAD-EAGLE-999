# Dedicated to my Shree DR.MDD

class ZebraPuzzle
  @answer : NamedTuple(drinks_water: String, owns_zebra: String)

  def initialize
    @answer = discover_solution
  end

  def drinks_water
    @answer[:drinks_water]
  end

  def owns_zebra
    @answer[:owns_zebra]
  end

  private ENGLISH   = 0
  private JAPANESE  = 1
  private NORWEGIAN = 2
  private SPANISH   = 3
  private UKRAINIAN = 4

  private BLUE   = 0
  private GREEN  = 1
  private IVORY  = 2
  private RED    = 3
  private YELLOW = 4

  private DOG    = 0
  private FOX    = 1
  private HORSE  = 2
  private SNAILS = 3
  private ZEBRA  = 4

  private COFFEE       = 0
  private MILK         = 1
  private ORANGE_JUICE = 2
  private TEA          = 3
  private WATER        = 4

  private CHESTERFIELD = 0
  private KOOL         = 1
  private LUCKY_STRIKE = 2
  private OLD_GOLD     = 3
  private PARLIAMENT   = 4

  private def nationality_name(id)
    %w[English Japanese Norwegian Spanish Ukrainian][id]
  end

  private def discover_solution
    range = (0..4).to_a

    range.permutations.each do |color_seq|
      next unless color_seq[GREEN] - 1 == color_seq[IVORY]

      range.permutations.each do |nation_seq|
        next unless nation_seq[NORWEGIAN] == 0
        next unless nation_seq[ENGLISH] == color_seq[RED]
        next unless (nation_seq[NORWEGIAN] - color_seq[BLUE]).abs == 1

        range.permutations.each do |pet_seq|
          next unless nation_seq[SPANISH] == pet_seq[DOG]

          range.permutations.each do |drink_seq|
            next unless drink_seq[COFFEE] == color_seq[GREEN]
            next unless nation_seq[UKRAINIAN] == drink_seq[TEA]
            next unless drink_seq[MILK] == 2

            range.permutations.each do |cigarette_seq|
              next unless cigarette_seq[OLD_GOLD] == pet_seq[SNAILS]
              next unless cigarette_seq[KOOL] == color_seq[YELLOW]
              next unless (cigarette_seq[CHESTERFIELD] - pet_seq[FOX]).abs == 1
              next unless (cigarette_seq[KOOL] - pet_seq[HORSE]).abs == 1
              next unless cigarette_seq[LUCKY_STRIKE] == drink_seq[ORANGE_JUICE]
              next unless nation_seq[JAPANESE] == cigarette_seq[PARLIAMENT]

              return {
                drinks_water: nationality_name(nation_seq[drink_seq[WATER]]),
                owns_zebra:   nationality_name(nation_seq[pet_seq[ZEBRA]])
              }
            end
          end
        end
      end
    end

    raise RuntimeError.new("No solution found")
  end
end
