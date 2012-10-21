Ton9::Application.routes.draw do

  #root
  root :to => "home#index"
  #devise
  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :registrations => "users/registrations"
  }
  #relation
  resources :users , :only => [:show] do
    get 'all' => 'users#all'
    resources :documents,:only => [:create, :index] do
      resources :items, :only => [:create, :index]
    end #end resources :documents
  end #end resources :users
 
 scope :binders do #なんかこいつうまく機能しねえｗ
    get 'binders/' => 'binders#index'
    post 'binders/' => 'binders#create'
    post 'binders/:binder_id' => 'binders#add_documents'
  end #end scope :binders
  
end
