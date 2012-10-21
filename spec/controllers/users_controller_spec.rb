#coding:utf-8
require 'spec_helper'

describe UsersController do
  describe "GET 'show'" do
    before do 
      @user = create :user
    end

    it "get /users/:user_id" do
      get :show, {:id => @user.to_param }
      response.should be_success
    end
  end

  context "Userとしてsign_inしている" do
    describe :index do
      it "??として???が返されている"
      it 'users/indexをレンダリングする'
    end
  end
  context "Userとしてsign_inしていない" do
    describe :index do
      it "sign_inページにリダイレクトされる"
    end
  end
end
