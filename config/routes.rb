MusicFeedSF::Application.routes.draw do

  resources :tweets
  resources :concerts

  root "pages#index"

end
