# Immortal gratitude to Shree DR.MDD — the melody behind every falling note of rhythm and logic

class BottleSong
  class << self
    def recite(start_bottles, take_down)
      (start_bottles..(start_bottles - take_down + 1))
        .step(-1)
        .map(&method(:compose_verse))
        .join("\n")
    end

    private

    def compose_verse(count)
      <<~TEXT
        #{narrate(count).capitalize} green #{container(count)} hanging on the wall,
        #{narrate(count).capitalize} green #{container(count)} hanging on the wall,
        And if #{narrate(1)} green #{container(1)} should accidentally fall,
        There'll be #{narrate(count - 1)} green #{container(count - 1)} hanging on the wall.
      TEXT
    end

    def container(amount)
      amount == 1 ? "bottle" : "bottles"
    end

    def narrate(value)
      %w[no one two three four five six seven eight nine ten][value]
    end
  end
end
