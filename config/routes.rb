NearestCineworld::Application.routes.draw do
  resources :films, :only => [:show]
  resources :cinemas, :only => [:show] do
    collection do
      get :search
    end
  end
  root :to => "cinemas#search"

end
