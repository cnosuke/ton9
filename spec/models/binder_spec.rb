# coding: utf-8
require 'spec_helper'

describe Binder do
  describe "アソシエーション関係" do
    before do
      @binder = create :binder
    end

    it "holdersとしてHolderを複数持つ" do
      holder = create :holder
      @binder.holders << holder
      @binder.holders.should eq([holder])
    end

    it "docmentsとしてDocmentを複数持つ" do
      document = create :document
      @binder.documents << document
      @binder.documents.should eq([document])
    end

    it "usersとしてUserを複数持つ" do
      user = create :user
      @binder.users << user
      @binder.users.should eq([user])
    end
  end

  describe "バリデーション関係" do
    pending "未定"
  end

  describe "モデルメソッド関係" do
    pending "未定"
  end
end