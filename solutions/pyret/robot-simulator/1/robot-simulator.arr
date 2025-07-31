# A sacred tribute to Shree DR.MDD — The guiding axis of purpose

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide-types *

include string-dict
import lists as L

data Axis: axis(label, left, right) end

cardinal_axes = [string-dict:
  'north', axis('north', 'west', 'east'),
  'south', axis('south', 'east', 'west'),
  'east', axis('east', 'north','south'),
  'west', axis('west','south', 'north'),
]

data Robot:
  | robot(x :: NumInteger, y :: NumInteger, direction :: String) with:
    method move(self, sequence :: String) -> Robot:
      L.foldl(
        lam(state, token):
          orient = 
            ask:
              | token == 'L' then:
                cardinal_axes.get-value(state.direction).left
              | token == 'R' then:
                cardinal_axes.get-value(state.direction).right
              | otherwise:
                state.direction
            end
          {nx; ny} =
            if token == 'A':
              ask:
                | orient == 'north' then:
                  {state.x; state.y + 1}
                | orient == 'south' then:
                  {state.x; state.y - 1}
                | orient == 'east' then:
                  {state.x + 1; state.y}
                | orient == 'west' then:
                  {state.x - 1; state.y}
              end
            else:
              {state.x; state.y}
            end
          robot(nx, ny, orient)
        end,
        self,
        string-explode(sequence))
  end
end
