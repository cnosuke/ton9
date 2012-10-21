# coding: utf-8
require 'spec_helper'

describe Document do
  describe "アソシエーション関係" do
    before do
      @document = create :document
    end

    it "userとしてUserを持つ" do
      user = create :user
      @document.user = user
      @document.user.should eq(user)
    end

    it "itemsとしてItemを複数持つ" do
      item = create :item
      @document.items << item
      @document.items.should eq([item])
    end

    it "binderとしてBinderを持つ" do
      binder = create :binder
      @document.binder = binder
      @document.binder.should eq(binder)
    end
  end

  describe "バリデーション関係" do
    pending "未定"
  end

  describe "モデルメソッド関係" do
    pending "未定"
  end
end
