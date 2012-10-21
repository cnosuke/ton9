#coding:utf-8
require 'spec_helper'

describe DocumentsController do
  before do 
    @user = create :user
  end
  
  describe "POST 'create'" do
    it 'post /users/:user_id/documents' do
      { :post => "/users/#{@user.id}/documents"}.should route_to(
                                                       :controller => "documents",
                                                       :action => "create",
                                                       :user_id => @user.id.to_s
                                                       )
    end
  end

  describe :create do
    context "成功した時" do
      it "Documentが作成されている"
      it "statusとしてsuccessが返される"
      it "encodingとして??が返される"
      pending "まだあるかも"
    end
    context "失敗した時" do
      it "Documentが作成されない"
      it "statusとしてfailureが返される"
      it "encodingとして??が返される"
      pending "まだあるかも"
    end
  end
end
