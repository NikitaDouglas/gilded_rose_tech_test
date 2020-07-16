class GildedRose

  MINIMUM_QUALITY = 0
  MAXIMUM_QUALITY = 50
  STANDARD_QUALITY_DECREASE = 1
  STANDARD_QUALITY_INCREASE = 1
  SELL_IN_DECREASE = 1
  SELL_IN_FINAL_DAY = 0
  BACKSTAGE_PASS_10_DAYS_LEFT = 10
  BACKSTAGE_PASS_5_DAYS_LEFT = 5

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - SELL_IN_DECREASE
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > MINIMUM_QUALITY
            item.quality = item.quality - STANDARD_QUALITY_DECREASE
        end
      else
        if item.quality < MAXIMUM_QUALITY
          item.quality = item.quality + STANDARD_QUALITY_INCREASE
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in <= BACKSTAGE_PASS_10_DAYS_LEFT
              if item.quality < MAXIMUM_QUALITY
                item.quality = item.quality + STANDARD_QUALITY_INCREASE
              end
            end
            if item.sell_in <= BACKSTAGE_PASS_5_DAYS_LEFT
              if item.quality < MAXIMUM_QUALITY
                item.quality = item.quality + STANDARD_QUALITY_INCREASE
              end
            end
          end
        end
      end
      if item.sell_in < SELL_IN_FINAL_DAY
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > MINIMUM_QUALITY
                item.quality = item.quality - STANDARD_QUALITY_DECREASE
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < MAXIMUM_QUALITY
            item.quality = item.quality + STANDARD_QUALITY_INCREASE
          end
        end
      end
    end
  end
end

  def update_quality_aged_brie
    
  end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end