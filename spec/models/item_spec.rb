# coding: utf-8
require 'spec_helper'

describe Item do
  describe "アソシエーション関係" do
    before do
      @item = create :item
    end

    it "userとしてUserを持つ" do
      user = create :user
      @item.user = user
      @item.user.should eq(user)
    end

    it "child_itemsとしてItemを複数持つ" do
      item = create :item
      @item.child_items << item
      @item.child_items.should eq([item])
    end

    it "parent_itemとしてItemを持つ" do
      item = create :item
      @item.parent_item = item
      @item.parent_item.should eq(item)
    end

    it "parent_documentとしてDocmentを持つ" do
      document = create :document
      @item.parent_document = document
      @item.parent_document.should eq(document)
    end
  end

  describe "バリデーション関係" do
    pending "未定"
  end

  describe "モデルメソッド関係" do
    pending "未定"
  end
end
