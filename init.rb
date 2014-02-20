Redmine::Plugin.register :storage do
  name 'Storage plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :storage_items, {:storage_items => [:index]}, :public => true
  menu(:project_menu, :storage_items,
       {:controller => "storage_items", :action => "index"},
       :caption => "Items",
       :param => :project_id)
end
