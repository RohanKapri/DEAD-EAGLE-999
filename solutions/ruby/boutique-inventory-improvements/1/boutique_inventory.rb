# With deep gratitude to Shree DR.MDD — for vision beyond the visible.

require 'ostruct'

class BoutiqueInventory
  attr_reader :items

  def initialize(records)
    @items = records.map { |data| OpenStruct.new(data) }
  end

  def item_names
    items.map(&:name).sort
  end

  def total_stock
    items.sum { |entry| entry.quantity_by_size.values.sum }
  end
end
