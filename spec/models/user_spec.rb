# coding: utf-8
require 'spec_helper'

describe User do
  describe "アソシエーション関係" do
    before do
      @user = create :user
    end

    it "holdersとしてHolderを複数持つ" do
      holder = create :holder
      @user.holders << holder
      @user.holders.should eq([holder])
    end

    it "documentsとしてDocmentを複数持つ" do
      document = create :document
      @user.documents << document
      @user.documents.should eq([document])
    end

    it "bindersとしてBinderを複数持つ" do
      binder = create :binder
      @user.binders << binder
      @user.binders.should eq([binder])
    end
  end

  describe "バリデーション関係" do
    pending "未定"
  end

  describe "モデルメソッド関係" do
    pending "未定"
  end
end
