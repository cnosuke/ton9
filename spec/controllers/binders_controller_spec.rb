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
end
