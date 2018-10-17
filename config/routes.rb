Rails.application.routes.draw do
  root to: 'search#hello'
  get '/twitter' => 'twitter#search', :as => 'search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
