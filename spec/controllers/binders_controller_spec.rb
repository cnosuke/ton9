# coding: utf-8
require 'spec_helper'

describe BindersController do
  before do
    @binder = create :binder
  end
  
  describe :create do
    context "成功した時" do
      it "Binderが作成されている"
      it "statusとしてsuccessが返される" do
        { :post => "/binders"}.should route_to(
                                               :controller => "binders",
                                               :action => "create",
                                               )
      end
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
      it "statusとしてsuccessが返される" do
        { :post => "/binders/#{@binder.id}"}.should route_to(
                                                             :controller => "binders",
                                                             :action => "add_documents",
                                                             :binder_id => @binder.id.to_s
                                                             )        
      end
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
