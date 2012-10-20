Ton9::Application.routes.draw do
  resources :users do
    resources :documents do
      resources :items

      scope :binders do
        post '/'
        post '/:bid'
      end
    end
  end
end
