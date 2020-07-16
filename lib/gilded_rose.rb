class GildedRose

  MINIMUM_QUALITY = 0
  MAXIMUM_QUALITY = 50
  STANDARD_QUALITY_DECREASE = 1
  STANDARD_QUALITY_INCREASE = 1
  PAST_SELL_IN_QUALITY_DECREASE = 2
  SELL_IN_DECREASE = 1
  SELL_IN_FINAL_DAY = 0
  BACKSTAGE_PASS_10_DAYS_LEFT = 10
  BACKSTAGE_PASS_5_DAYS_LEFT = 5
  BACKSTAGE_PASS_10_DAYS_LEFT_QUALITY_INCREASE = 2
  BACKSTAGE_PASS_5_DAYS_LEFT_QUALITY_INCREASE = 3
  AGED_BRIE_PAST_SELL_IN_INCREASE = 2
  LEGENDARY_ITEMS = ["Sulfuras, Hand of Ragnaros"]

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if LEGENDARY_ITEMS.include?(item.name)
      item.sell_in -= SELL_IN_DECREASE
      next if is_maximum_quality?(item.quality)

      if is_above_minimum_quality(item.quality)
        if item.name == "Aged Brie"
          update_aged_brie(item)
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          update_back_stage_passes(item)
        else
          if is_after_sell_in_final_day?(item.sell_in)
            item.quality -= PAST_SELL_IN_QUALITY_DECREASE
          else
            item.quality -= STANDARD_QUALITY_DECREASE
          end
        end
      end     
    end     
  end

  private

  def is_maximum_quality?(item_quality)
    item_quality == MAXIMUM_QUALITY
  end

  def is_above_minimum_quality(item_quality)
    item_quality > MINIMUM_QUALITY
  end

  def is_after_sell_in_final_day?(item_sell_in)
    item_sell_in < SELL_IN_FINAL_DAY
  end

  def update_aged_brie(item)
    if is_after_sell_in_final_day?(item.sell_in)
      item.quality += AGED_BRIE_PAST_SELL_IN_INCREASE
    else
      item.quality += STANDARD_QUALITY_INCREASE
    end
  end

  def update_back_stage_passes(item)
    if is_after_sell_in_final_day?(item.sell_in)
      item.quality -= item.quality
    elsif item.sell_in <= BACKSTAGE_PASS_5_DAYS_LEFT
      item.quality += BACKSTAGE_PASS_5_DAYS_LEFT_QUALITY_INCREASE
    elsif item.sell_in <= BACKSTAGE_PASS_10_DAYS_LEFT
      item.quality += BACKSTAGE_PASS_10_DAYS_LEFT_QUALITY_INCREASE
    else
      item.quality += STANDARD_QUALITY_INCREASE
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