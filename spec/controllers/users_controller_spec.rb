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

end
