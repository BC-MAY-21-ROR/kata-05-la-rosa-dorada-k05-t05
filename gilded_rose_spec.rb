# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'does quality degrades when the GildedRose update quality' do
      items = [Item.new('foo', 2, 6)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 5
    end

    it 'does SellIn degrades when the GildedRose update quality' do
      items = [Item.new('foo', 2, 6)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eql 1
    end

    it 'does quality degrades twice as fast, once the sell by date has passed' do
      items = [Item.new('foo', 0, 6)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 4
    end

    it 'does Aged Brie increase the quality the older it gets' do
      items = [Item.new('Aged Brie', 1, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 1
    end

    it 'does Aged Brie increase twice fast the quality, once the sell by date has passed' do
      items = [Item.new('Aged Brie', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 2
    end

    it 'does Aged Brie quality is never more than 50' do
      items = [Item.new('Aged Brie', 0, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 50
    end

    it 'does Sulfuras never decreases in Quality' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 10
    end

    it 'does Sulfuras never has to be sold' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eql 10
    end

    it 'does Backstage passes increases in Quality as its SellIn value approaches' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 20, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 11
    end

    it 'does Backstage passes increases in Quality as its SellIn value approaches to ten days or less' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 12
    end

    it 'does Backstage passes increases in Quality as its SellIn value approaches to five days or less' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 13
    end

    it 'does Backstage passes Quality drops to 0 after the concert' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 0
    end

    it 'does Backstage quality is never more than 50' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 2, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 50
    end

    it 'does Conjured degrade in Quality twice as fast as normal items' do
      items = [Item.new('Conjured Potion', 2, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 8
    end

    it 'does Conjured degrade in Quality twice as fast as normal items even the SellIn date has passed' do
      items = [Item.new('Conjured Golden Fish', 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eql 6
    end
  end
end
