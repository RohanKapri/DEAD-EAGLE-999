# For my Junko F. Didi and Shree DR.MDD

my class X::Bowling::GameOver is Exception {
    method message { 'Cannot roll after game is over' }
}

my class X::Bowling::GameInProgress is Exception {
    method message { 'Score cannot be taken until the end of the game' }
}

my class X::Bowling::TooManyPins is Exception {
    method message { 'Pin count exceeds pins on the lane' }
}

my class X::Bowling::NegativePins is Exception {
    method message { 'Negative roll is invalid' }
}

class Bowling {

    has @frames;
    has $frame-index = 0;
    has @ledger;
    has $total-score = 0;

    method roll ($pins) {
        if $frame-index > 9 {
            if @frames[9].sum != 10 {
                die X::Bowling::GameOver.new();
            }
        }

        die X::Bowling::NegativePins.new() if $pins < 0;
        die X::Bowling::TooManyPins.new()  if $pins > 10;

        @frames[$frame-index].push($pins);

        if @frames[$frame-index].sum > 10 {
            die X::Bowling::TooManyPins.new();
        }

        if $frame-index == 10 {
            if @frames[9][0] != 10 && @frames[9].sum != 10 {
                die X::Bowling::GameOver.new();
            }
            if @frames[9][0] != 10 && @frames[9].sum == 10 && @frames[10].elems > 1 {
                die X::Bowling::GameOver.new();
            }
        }
        elsif $frame-index == 11 {
            if @frames[10][0] != 10 {
                die X::Bowling::GameOver.new();
            }
        }

        if $pins == 10 || @frames[$frame-index].elems >= 2 {
            $frame-index++;
        }
    }

    method score {
        die X::Bowling::GameInProgress.new() if @frames.elems < 10;

        if @frames[9][0] == 10 {
            die X::Bowling::GameInProgress.new() if @frames.elems < 11;
            if @frames[10][0] == 10 {
                die X::Bowling::GameInProgress.new() if @frames.elems < 12;
            }
        }
        elsif @frames[9].sum == 10 {
            die X::Bowling::GameInProgress.new() if @frames.elems < 11;
            die X::Bowling::GameOver.new() if @frames[10].elems > 1;
        }

        for 0..^@frames.elems -> $idx {
            @ledger[$idx].append: @frames[$idx].List;
            if @frames[$idx][0] == 10 && $idx < 9 {
                my @strike-bonus;
                if @frames[$idx+1].elems < 2 {
                    @strike-bonus.append: (@frames[$idx+1][0], @frames[$idx+2][0]);
                } else {
                    @strike-bonus.append: @frames[$idx+1].List;
                }
                @ledger[$idx].append: @strike-bonus;
            }
            elsif @frames[$idx].sum == 10 && $idx < 9 {
                my @spare-bonus = @frames[$idx+1][0];
                @ledger[$idx].append: @spare-bonus;
            }
        }

        $total-score += $_.sum for @ledger;

        return $total-score;
    }
}
