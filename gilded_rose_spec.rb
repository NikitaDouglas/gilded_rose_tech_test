require File.join(File.dirname(__FILE__), 'gilded_rose')

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

    it "reduces the quality by 1, when sell-in > 0" do
      items = [Item.new("foo", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
    end
  end

end
