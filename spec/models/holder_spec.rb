# coding: utf-8
require 'spec_helper'

describe Holder do
  describe "アソシエーション関係" do
    before do
      @holder = create :holder
    end

    it "userとしてUserを持つ" do
      user = create :user
      @holder.user = user
      @holder.user.should eq(user)
    end

    it "binderとしてBinderを持つ" do
      binder = create :binder
      @holder.binder = binder
      @holder.binder.should eq(binder)
    end
  end

  describe "バリデーション関係" do
    pending "未定"
  end

  describe "モデルメソッド関係" do
    pending "未定"
  end
end
