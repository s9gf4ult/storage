
class StorageItemsHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, :partial => "storage_items/issue_description_hook"
end
