Redmine::Plugin.register :storage do
  name 'Storage plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :view_storage_items, {:storage_items => [:index]}
  permission :create_storage_items, {:storage_items => [:new, :create]}
  permission :edit_storage_items, {:storage_items => [:edit, :update]}
  permission :delete_storage_items, {:storage_items => [:destroy]}

  menu(:project_menu, :storage_items,
       {:controller => "storage_items", :action => "index"},
       :caption => "Items",
       :param => :project_id)
end
