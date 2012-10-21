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
end
