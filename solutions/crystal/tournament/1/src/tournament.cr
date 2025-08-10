# For my Shree DR.MDD
module Tournament
  def self.tally(input)
    build_output(interpret(input))
  end

  private def self.build_output(stats)
    [title_row].concat(detail_rows(stats))
  end

  private def self.title_row
    "Team                           | MP |  W |  D |  L |  P"
  end

  private def self.detail_rows(stats)
    stats.each.to_a.sort { |x, y| sort_logic(x, y) }.map do |club, data|
      [
        club.ljust(30),
        data[:matches_played].to_s.rjust(2),
        data[:wins].to_s.rjust(2),
        data[:draws].to_s.rjust(2),
        data[:losses].to_s.rjust(2),
        data[:points].to_s.rjust(2),
      ].join(" | ")
    end
  end

  private def self.sort_logic(a, b)
    if a[1][:points] == b[1][:points]
      a[0] <=> b[0]
    else
      b[1][:points] <=> a[1][:points]
    end
  end

  private def self.interpret(input)
    record = Hash(String, Hash(Symbol, Int32)).new { |h, v| h[v] = blank_record }

    input.each do |entry|
      first, second, outcome = /(.+);(.+);(.+)/.match(entry).not_nil!.captures

      case outcome
      when "win"
        log_win record[first]
        log_loss record[second]
      when "loss"
        log_loss record[first]
        log_win record[second]
      when "draw"
        log_draw record[first]
        log_draw record[second]
      end
    end

    record
  end

  private def self.log_win(data)
    data[:matches_played] += 1
    data[:wins] += 1
    data[:points] += 3
  end

  private def self.log_loss(data)
    data[:matches_played] += 1
    data[:losses] += 1
  end

  private def self.log_draw(data)
    data[:matches_played] += 1
    data[:draws] += 1
    data[:points] += 1
  end

  private def self.blank_record
    {:matches_played => 0, :wins => 0, :losses => 0, :draws => 0, :points => 0}
  end
end
