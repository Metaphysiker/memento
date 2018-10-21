Rails.application.routes.draw do
  resources :tasks
  resources :notes
  resources :institutions
  resources :tag_lists
  resources :addresses
  resources :people
  resources :basic
  devise_for :users


  root 'static_pages#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #static_pages
  get '/overview', to: 'static_pages#overview', as: 'overview'
  get '/my_tasks', to: 'static_pages#my_tasks', as: 'my_tasks'

  #search
  get '/search_people_form', to: 'people#search_people', as: 'search_people_form'
  get '/search_institutions_form', to: 'institutions#search_institutions', as: 'search_institutions_form'
  get '/search_basic_form', to: 'basic#search_basic', as: 'search_basic_form'

  #activities
  get '/activities', to: 'static_pages#activities', as: 'activities'

  #playfield
  get '/playfield', to: 'static_pages#playfield', as: 'playfield'

  #render
  get '/render_shared', to: 'render#render_shared', as: 'render_shared'
end
