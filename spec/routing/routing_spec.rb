require 'spec_helper'

describe :routes do
  before :all do
    @binder   =   create :binder
    @user     =   create :user
    @document =   create :document
  end
  it %Q(post '/binders' -> 'binders#create') do
    { :post => "/binders"}.should route_to(:controller => "binders", :action => "create")
  end

  it %Q(post '/binders/:binder_id' -> 'binders#add_documents#:binder_id') do
    { :post => "/binders/#{@binder.id}"}.should
        route_to(   :controller   => "binders",
                    :action       => "add_documents",
                    :binder_id    => @binder.id.to_s)
  end

  it %Q(post '/users/:user_id/documents' -> 'documents#create#:user_id') do
    { :post => "/users/#{@user.id}/documents"}.should
        route_to(   :controller => "documents",
                    :action => "create",
                    :user_id => @user.id.to_s)
  end

  it %Q(get '/' -> 'home#index') do
    { :get => "/"}.should
        route_to(   :controller => "home",
                    :action => "index")
  end

  it %Q(post '/users/:user_id/documents/:document_id/items' -> 'items#create#:user_id#:document_id') do
    { :post => "/users/#{@user.id}/documents/#{@document.id}/items"}.should
        route_to(   :controller => "items",
                    :action => "create",
                    :user_id => @user.id.to_s,
                    :document_id => @document.id.to_s)
  end

  it %Q(get '/users/:user_id') do
    {:get => "/users/#{@user.name}"}.should
        route_to(   :controller => "users",
                    :action     => "show",
                    :id         => @user.name)
    end
end