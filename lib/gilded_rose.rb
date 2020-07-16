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
      next if item.quality == MAXIMUM_QUALITY

      if item.quality > MINIMUM_QUALITY
        if item.name == "Aged Brie"
          update_aged_brie(item)
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          update_back_stage_passes(item)
        else
          if item.sell_in < SELL_IN_FINAL_DAY
            item.quality = item.quality - 2
          else
            item.quality = item.quality - STANDARD_QUALITY_DECREASE
          end
        end
      end     
    end     
  end

  private

  def update_aged_brie(item)
    if item.sell_in < SELL_IN_FINAL_DAY
      item.quality = item.quality + 2
    else
      item.quality = item.quality + STANDARD_QUALITY_INCREASE
    end
  end

  def update_back_stage_passes(item)
    if item.sell_in < SELL_IN_FINAL_DAY
      item.quality = item.quality - item.quality
    elsif item.sell_in <= BACKSTAGE_PASS_5_DAYS_LEFT
      item.quality = item.quality + 3
    elsif item.sell_in <= BACKSTAGE_PASS_10_DAYS_LEFT
      item.quality = item.quality + 2
    else
      item.quality = item.quality + STANDARD_QUALITY_INCREASE
    end 
  end
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