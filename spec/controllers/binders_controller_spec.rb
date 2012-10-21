#coding:utf-8
require 'spec_helper'

describe BindersController do
  before do
    @binder = create :binder
  end

  describe "POST 'create'" do
    it 'post /binders' do
      { :post => "/binders"}.should route_to(
                                             :controller => "binders",
                                             :action => "create",
                                             )
    end
  end
  
  describe "POST 'add_documents'" do
    it 'post /binders/:binder_id' do
      { :post => "/binders/#{@binder.id}"}.should route_to(
                                                           :controller => "binders",
                                                           :action => "add_documents",
                                                           :binder_id => @binder.id.to_s
                                                           )
    end
  end

  describe :create do
    context "成功した時" do
      it "Binderが作成されている"
      it "statusとしてsuccessが返される"
      it "encodingとして??が返される"
      pending "まだあるかも"
    end
    context "失敗した時" do
      it "Binderが作成されない"
      it "statusとしてfailureが返される"
      it "encodingとして??が返される"
      pending "まだあるかも"
    end
  end
  
  describe :add_documents do
    context "成功した時" do
      it "Documentが追加されている"
      it "statusとしてsuccessが返される"
      it "encodingとして??が返される"
      pending "まだあるかも"
    end
    context "失敗した時" do
      it "Documentが追加されていない"
      it "statusとしてfailureが返される"
      it "encodingとして??が返される"
      pending "まだあるかも"
    end
  end
end
