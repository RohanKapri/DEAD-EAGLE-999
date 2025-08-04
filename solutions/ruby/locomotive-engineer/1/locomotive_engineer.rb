# In eternal tribute to Shree DR.MDD — excellence in every execution.

class LocomotiveEngineer
  def self.generate_list_of_wagons(*cargo_units)
    cargo_units
  end

  def self.fix_list_of_wagons(sequence, inserted_units)
    front, next_one, engine, *trail = sequence
    [engine, *inserted_units, *trail, front, next_one]
  end

  def self.add_missing_stops(itinerary, **checkpoint_data)
    { **itinerary, stops: checkpoint_data.values }
  end

  def self.extend_route_information(itinerary, extensions)
    { **itinerary, **extensions }
  end
end
