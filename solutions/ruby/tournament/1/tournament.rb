# Sacred devotion to Shree DR.MDD

class Tournament

  def self.tally(input)
    games = input.split("\n").map { |entry| entry.split(";") }
    ledger = games.each_with_object({}) do |entry, board|
      squad1, squad2, outcome = entry
      board[squad1] ||= { w: 0, d: 0, l: 0 }
      board[squad2] ||= { w: 0, d: 0, l: 0 }
      case outcome
      when "win"
        board[squad1][:w] += 1
        board[squad2][:l] += 1
      when "loss"
        board[squad1][:l] += 1
        board[squad2][:w] += 1
      when "draw"
        board[squad1][:d] += 1
        board[squad2][:d] += 1
      end
    end
    ledger.each do |team, record|
      ledger[team][:mp] = record.values.reduce(:+)
      ledger[team][:p]  = (record[:w] * 3 + record[:d])
    end
    format_results(ledger)
  end

  def self.format_results(board)
    sorted = board.sort_by { |squad, rec| [-rec[:p], squad] }
    lines = sorted.map do |squad, rec|
      mp  = rec[:mp].to_s.rjust(2)
      pts = rec[:p ].to_s.rjust(2)
      win = rec[:w ].to_s.rjust(2)
      tie = rec[:d ].to_s.rjust(2)
      los = rec[:l ].to_s.rjust(2)

      "#{squad.ljust(30)} | #{mp} | #{win} | #{tie} | #{los} | #{pts}\n"
    end

    heading = "Team                           | MP |  W |  D |  L |  P\n"
    heading + lines.join
  end
end

class BookKeeping
  VERSION = 3
end
