Ton9::Application.routes.draw do
  #resources :users do
  #  resources :documents do
  #    resources :items

  #    scope :binders do
  #      post '/'
  #      post '/:bid'
  #    end
  #  end
  #end

  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :registrations => "users/registrations"
  }

  root :to => "home#index"
end
