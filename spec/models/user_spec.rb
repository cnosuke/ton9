require 'spec_helper'

describe User do
  describe "属性関係" do
    it "nameがある"
    it "iconがある"
  end

  describe "アソシエーション関係" do
    it "holdersとしてHolderを複数持つ"
    it "docmentsとしてDocmentを複数持つ"
    it "bindersとしてBinderを複数持つ"
  end
end
