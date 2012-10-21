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
    sample_is_valid       :user
    unsample_is_not_valid :user, name: nil
    non_uniq_is_not_valid :user, :name
    unsample_is_not_valid :user, name: "aa/bb"
    unsample_is_not_valid :user, name: "あああ"
    unsample_is_not_valid :user, name: "aa#bb"
    unsample_is_not_valid :user, name: "aa=bb"
    unsample_is_not_valid :user, email: nil
    unsample_is_not_valid :user, email: "aa"
    unsample_is_not_valid :user, password: nil
  end

  describe "モデルメソッド関係" do
    pending "未定"
  end
end
