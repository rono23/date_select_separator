Dummy::Application.routes.draw do
  resources :samples
  root 'samples#index'
end
