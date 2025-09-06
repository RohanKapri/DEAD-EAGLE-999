reduce (.instructions // "" | split("")[]) as $x (
  .robot;
  if $x == "A" then
    if   .direction == "north" then .position.y += 1
    elif .direction == "south" then .position.y -= 1
    elif .direction == "east"  then .position.x += 1
    else                            .position.x -= 1
    end
  elif $x == "R" then
    .direction |= {north: "east", east: "south", south: "west", west: "north"}[.]
  else
    .direction |= {north: "west", west: "south", south: "east", east: "north"}[.]
  end
)