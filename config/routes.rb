Rails.application.routes.draw do
  resources :addresses

  #people
  resources :people

  get '/people_pagination', to: 'people#people_pagination', as: 'people_pagination'


  devise_for :users
  root 'static_pages#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #search
  get '/search_people_form', to: 'people#search_people', as: 'search_people_form'

  #activities
  get '/activities', to: 'static_pages#activities', as: 'activities'

  #playfield
  get '/playfield', to: 'static_pages#playfield', as: 'playfield'


end
