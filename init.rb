Redmine::Plugin.register :storage do
  require 'storage_items_hook_listener'

  name 'Storage plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :storage do
    permission :view_storage_items, {:storage_items => [:index]}
    permission :create_storage_items, {:storage_items => [:new, :create]}
    permission :edit_storage_items, {:storage_items => [:edit, :update]}
    permission :delete_storage_items, {:storage_items => [:destroy]}

    permission :view_storage_tasks, {:storage_tasks => [:index]}, :public => true
  end

  menu(:project_menu, :storage_items,
       {:controller => "storage_items", :action => "index"},
       :caption => "Items",
       :param => :project_id)
  menu(:project_menu, :storage_tasks,
       {:controller => "storage_tasks", :action => "index"},
       :caption => "Tasks")
end
