Rails.application.routes.draw do
  resources :groups
  resources :projects
  resources :tasks
  resources :notes
  resources :institutions
  resources :tag_lists
  resources :addresses
  resources :people
  resources :basic
  resources :affiliations
  devise_for :users


  root 'static_pages#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #static_pages
  get '/overview', to: 'static_pages#overview', as: 'overview'
  get '/my_tasks', to: 'static_pages#my_tasks', as: 'my_tasks'
  get '/team', to: 'static_pages#team', as: 'team'

  #search
  get '/search_people_form', to: 'people#search_people', as: 'search_people_form'
  get '/search_institutions_form', to: 'institutions#search_institutions', as: 'search_institutions_form'
  get '/search_basic_form', to: 'basic#search_basic', as: 'search_basic_form'
  get '/search_list_form', to: 'basic#search_list', as: 'search_list_form'

  #activities
  get '/activities', to: 'static_pages#activities', as: 'activities'

  #playfield
  match '/playfield', to: 'static_pages#playfield', as: 'playfield', via: [:get, :post]

  #render
  get '/render_shared', to: 'render#render_shared', as: 'render_shared'
  get '/render_index', to: 'render#render_index', as: 'render_index'
  get '/render_tags', to: 'render#render_tags', as: 'render_tags'
  post '/render_project_people', to: 'render#render_project_people', as: 'render_project_people'
  post '/render_group_people', to: 'render#render_group_people', as: 'render_group_people'


  #csv
  get '/basic_csv', to: 'basic#csv', as: 'basic_csv'

  #pdf
  get '/basic_pdf', to: 'basic#pdf', as: 'basic_pdf'

  #odf
  get '/basic_odf', to: 'basic#odf', as: 'basic_odf'
  get '/person_bill/:id', to: 'people#odf', as: 'person_bill'

  #affiliations
  patch '/update_person_affiliation/:id', to: 'affiliations#update_person_affiliation', as: 'update_person_affiliation'
  patch '/update_institution_affiliation/:id', to: 'affiliations#update_institution_affiliation', as: 'update_institution_affiliation'

  #project
  post '/add_people_to_project', to: 'projects#add_people_to_project', as: 'add_people_to_project'
  post '/remove_people_to_project', to: 'projects#remove_people_to_project', as: 'remove_people_to_project'

  #group
  post '/add_people_to_group', to: 'groups#add_people_to_group', as: 'add_people_to_group'
  post '/remove_people_from_group', to: 'groups#remove_people_from_group', as: 'remove_people_from_group'
  post '/search_selectable_list_to_add_people', to: 'groups#search_selectable_list_to_add_people', as: 'search_selectable_list_to_add_people'
end
