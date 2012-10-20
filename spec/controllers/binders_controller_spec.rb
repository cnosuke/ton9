require 'spec_helper'

describe BindersController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'add_documents'" do
    it "returns http success" do
      get 'add_documents'
      response.should be_success
    end
  end

end
