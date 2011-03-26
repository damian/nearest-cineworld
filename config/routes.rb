NearestCineworld::Application.routes.draw do
  resources :films, :only => [:index, :show]
  resources :cinemas, :only => [:index, :show] do
    resources :films, :only => [:index]
    collection do
      get :search
    end
  end
  root :to => "cinemas#index"

end
