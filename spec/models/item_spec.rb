require 'spec_helper'

describe Item do
  describe "属性関係" do
    it "contentがある"
  end

  describe "アソシエーション関係" do
    it "child_itemsとしてItemを複数持つ"
    it "parent_itemとしてItemを持つ"
    it "parent_documentとしてDocmentを持つ"
  end
end
