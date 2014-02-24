# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :storage_items, :except => [:show]

resources :storage_tasks, :only => [:index]
