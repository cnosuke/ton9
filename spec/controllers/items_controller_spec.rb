# coding: utf-8
require 'spec_helper'

describe ItemsController do
  before do 
    @user = create :user
    @document = create :document
  end

  describe :create do
    context "成功した時" do
      it "Itemが作成されている"
      it "resultとしてが返される"
      it "encodingとして??が返される"
      pending "まだあるかも"
    end

    context "失敗した時" do
      it "Itemが作成されない"
      it "resultとしてが返される"
      it "dataとして??が返される"
      pending "まだあるかも"
    end
  end
end
