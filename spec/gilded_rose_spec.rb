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
  end
end
