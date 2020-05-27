Rails.application.routes.draw do
  resources :payments
  resources :languages
  resources :topics
  get 'blogs/new_for_calendar/(:planning_date)', to: 'blogs#new_for_calendar', as: "new_for_calendar"

  resources :blogs
  resources :work_times
  resources :working_hours
  resources :groups
  resources :projects
  resources :tasks
  resources :notes
  resources :people
  resources :tag_lists
  resources :addresses
  resources :institutions
  resources :basic
  resources :affiliations
  devise_for :users


  root 'static_pages#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #static_pages
  get '/overview', to: 'static_pages#overview', as: 'overview'
  get '/my_tasks/(:user_id)', to: 'static_pages#my_tasks', as: 'my_tasks'
  get '/my_worktime', to: 'static_pages#my_worktime', as: 'my_worktime'
  get '/team', to: 'static_pages#team', as: 'team'
  get '/merch_showcase', to: 'static_pages#merch_showcase', as: 'merch_showcase'
  get '/manual', to: 'static_pages#manual', as: 'manual'
  get '/worktime', to: 'static_pages#worktime', as: 'worktime'
  get '/members', to: 'static_pages#members', as: 'members'

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
  get '/render_notes_and_tasks', to: 'render#render_notes_and_tasks', as: 'render_notes_and_tasks'
  get '/render_index', to: 'render#render_index', as: 'render_index'
  get '/render_tags', to: 'render#render_tags', as: 'render_tags'
  post '/render_project_people', to: 'render#render_project_people', as: 'render_project_people'
  post '/render_group_people', to: 'render#render_group_people', as: 'render_group_people'


  #csv
  get '/basic_csv', to: 'csv#basic_csv', as: 'basic_csv'
  get '/headers_csv', to: 'csv#headers_csv', as: 'headers_csv'
  get '/example_csv', to: 'csv#example_csv', as: 'example_csv'

  #pdf
  get '/basic_pdf', to: 'pdf#basic_pdf', as: 'basic_pdf'

  #odf
  get '/basic_odf', to: 'basic#odf', as: 'basic_odf'
  get '/person_bill/:id', to: 'people#odf', as: 'person_bill'

  #odf_of_list_of_members
  get '/person_list_of_members/', to: 'people#odf_of_list_of_members', as: 'odf_of_list_of_members'

  #Serienbrief
  get '/people_serienbrief/', to: 'people#serienbrief', as: 'people_serienbrief'
  get '/institutions_serienbrief/', to: 'institutions#serienbrief', as: 'institutions_serienbrief'

  #Brief an mitglieder
  get '/people_brief_an_mitglieder/', to: 'people#brief_an_mitglieder', as: 'people_brief_an_mitglieder'

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
  post '/search_selectable_list_to_remove_people', to: 'groups#search_selectable_list_to_remove_people', as: 'search_selectable_list_to_remove_people'
  post '/create_for_project', to: 'groups#create_for_project', as: 'create_for_project'

  #import and upload
  get '/import_people_page', to: 'import#import_people_page', as: 'import_people_page'
  post '/import_people', to: 'import#import_people', as: 'import_people'
  get '/import_institutions_page', to: 'import#import_institutions_page', as: 'import_institutions_page'
  post '/import_institutions', to: 'import#import_institutions', as: 'import_institutions'

  get '/testing', to: 'import#testing', as: 'testing'

  get '/import_working_hours_page', to: 'import#import_working_hours_page', as: 'import_working_hours_page'
  post '/import_working_hours', to: 'import#import_working_hours', as: 'import_working_hours'

  post '/import_work_time', to: 'import#import_work_time', as: 'import_work_time'

  #task
  post '/normal_create_task', to: 'tasks#normal_create', as: 'normal_create_task'
  get '/task_calendar/(:date)/(:user_id)', to: 'tasks#task_calendar', as: 'task_calendar'
  #get '/task_calendar', to: 'tasks#task_calendar', as: 'task_calendar'

  #blog
  get 'blog_calendar/(:date)/(:language)', to: 'blogs#blog_calendar', as: "blog_calendar"
  get 'blog_list/(:date)/(:language)', to: 'blogs#blog_list', as: "blog_list"
  post 'create_for_calendar', to: 'blogs#create_for_calendar', as: "create_for_calendar"
end
