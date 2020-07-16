require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "reduces the sell_in value by 1" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq -1
    end

    it "never reduces the quality of any item below 0" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "reduces the quality by 1, when sell_in > 0" do
      items = [Item.new("foo", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
    end

    it "reduces the quality by 2, when sell_in < 0" do
      items = [Item.new("foo", -1, 5)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end
  end

  describe "#update_quality for 'Aged Brie'" do
    it "increases the quality by 1, when sell_in > 0" do
      items = [Item.new("Aged Brie", 2, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    it "increases the quality by 2, when sell_in < 0" do
      items = [Item.new("Aged Brie", 0, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end

    it "never increases the quality of 'Aged Brie' above 50" do
      items = [Item.new("Aged Brie", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end
  end

  describe "#update_quality for 'Backstage passes to a TAFKAL80ETC concert'" do
    it "increases the quality by 1, when sell_in > 10" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    it "increases the quality by 2, when sell_in <= 10 and > 5" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end

    it "increases the quality by 2, when sell_in <= 5" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 4
    end
  end
end
