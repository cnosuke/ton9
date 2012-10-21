require 'spec_helper'

describe ItemsController do
  before do 
    @user = create :user
    @document = create :document
  end
  
  describe "POST 'create'" do
    it 'post /users/:user_id/documents/:document_id/items' do
      { :post => "/users/#{@user.id}/documents/#{@document.id}/items"}.should route_to(
                                                       :controller => "items",
                                                       :action => "create",
                                                       :user_id => @user.id.to_s,
                                                       :document_id => @document.id.to_s
                                                       )
    end
  end

end
