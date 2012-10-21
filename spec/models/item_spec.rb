# coding: utf-8
require 'spec_helper'

describe Item do
  describe "アソシエーション関係" do
    before do
      @item = create :item
    end

    it "child_itemsとしてItemを複数持つ" do
      item = create :item
      @item.child_items << item
      @item.child_items.should eq([item])
    end

    it "parent_itemとしてItemを持つ" do
      item = create :item
      @item.parent_item = item
      @item.save
      @item.parent_item.should eq(item)
    end

    it "parent_documentとしてDocmentを持つ" do
      document = create :document
      @item.parent_document = document
      @item.save
      @item.parent_document.should eq(document)
      p "¥n\n"
    end
  end

  describe "バリデーション関係" do
    sample_is_valid       :item
    sample_is_valid       :item, content: ""
    unsample_is_not_valid_for_char_count :item, :content, 1025

    it "Item.contentが空のときは空文字として保存される" do
      sample = FactoryGirl.build :item, {:content => nil}
      sample.should be_valid
    end
  end

  describe "モデルメソッド関係" do
    pending "未定"
  end
end
