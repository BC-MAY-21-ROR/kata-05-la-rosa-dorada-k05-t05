# frozen_string_literal: true

# The GildedRose class represents a system in place that updates our inventory
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
          item.quality = item.quality - 1
          conjured = (item.name).split(' ')
          item.quality -= 1 if conjured[0] == 'Conjured'
        end
      elsif item.quality < 50
        item.quality = item.quality + 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = item.quality + 1 if item.sell_in < 11 && (item.quality < 50)
          item.quality = item.quality + 1 if item.sell_in < 6 && (item.quality < 50)
        end
      end
      item.sell_in = item.sell_in - 1 if item.name != 'Sulfuras, Hand of Ragnaros'
      if item.sell_in.negative?
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
              item.quality = item.quality - 1
              conjured = (item.name).split(' ')
              item.quality -= 1 if conjured[0] == 'Conjured'
            end
          else
            item.quality = item.quality - item.quality
          end
        elsif item.quality < 50
          item.quality = item.quality + 1
        end
      end
    end
  end
end

# The Item class represents a type of product that is sold in Gilded Rose

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end