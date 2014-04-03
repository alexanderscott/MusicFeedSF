ArtBuzzSF::Application.routes.draw do

  resources :tweets
  resources :events

  root "pages#index"

end
