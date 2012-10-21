# coding: utf-8
require 'spec_helper'

describe ItemsController do
  before do 
    @user = create :user
    @document = create :document
  end

  describe :create do
    context "成功した時1" do
      it "Itemが作成されている"
      it "resultとして1が返される"
      it "encodingとして??が返される"
      pending "まだあるかも"
    end

    context "失敗した時0" do
      it "Itemが作成されない"
      it "resultとして0が返される"
      it "dataとして??が返される"
      pending "まだあるかも"
    end
  end
end
