Ton9::Application.routes.draw do
  resources :users , :only => [:index] do
    resources :documents,:only => [:create] do
      scope :binders do #なんかこいつうまく機能しねえｗ
        post 'binders/' => 'binders#create'
        post 'binders/:binder_id' => 'binders#add_documents'
      end #end scope :binders
      resources :items, :only => [:create]
    end #end resources :documents
  end #end resources :users

  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :registrations => "users/registrations"
  }

  root :to => "home#index"
end
