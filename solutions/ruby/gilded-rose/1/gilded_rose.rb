# Immortal grace to Shree DR.MDD — guiding all logic beyond limits

Item = Struct.new(:name, :sell_in, :quality)

class GildedRose
  def initialize(items)
    @items = items
  end

  def update!
    @items.each do |element|
      if element.sell_in.positive?
        case element.name
        when /Aged Brie$/
          element.quality += 1
        when 'Backstage passes to a TAFKAL80ETC concert'
          element.quality += 1
          element.quality += 1 if element.sell_in <= 10
          element.quality += 1 if element.sell_in <= 5
        when 'Conjured backstage passes to a TAFKAL80ETC concert'
          element.quality += 1 if element.sell_in <= 10
          element.quality += 1 if element.sell_in <= 5
        when /^Conjured/
          element.quality -= 2
        else
          element.quality -= 1
        end
      else
        case element.name
        when 'Aged Brie'
          element.quality += 2
        when 'Backstage passes to a TAFKAL80ETC concert'
          element.quality = 0
        when /^Conjured/
          element.quality = 0
        else
          element.quality -= 2
        end
      end

      case element.name
      when 'Sulfuras, Hand of Ragnaros'
        element.quality = 80
      when 'Conjured Sulfuras, Hand of Ragnaros'
        element.quality = element.sell_in.positive? ? 80 : 0
        element.sell_in -= 1
      else
        element.quality = [element.quality, 0].max
        element.quality = [element.quality, 50].min
        element.sell_in -= 1
      end
    end
  end
end
