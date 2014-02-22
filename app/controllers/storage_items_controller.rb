class StorageItemsController < ApplicationController
  unloadable

  before_filter :find_project, :only => [:index, :new]
  before_filter :find_item, :only => [:edit, :update, :destroy]
  before_filter :authorize

  helper :sort
  include SortHelper


  def index
    sort_init 'name', 'asc'
    sort_update %w(name cost count production_time)

    scope = StorageItem.joins(:issue => [:project]).where("projects.id" => @project.id)
    scope = scope.name_like(params[:name]) if params[:name].present?
    @items = scope.order(sort_clause)
  end

  def edit
    @project = @item.issue.try(:project)
  end

  def new
    @item = StorageItem.new
  end

  def create
    @item = StorageItem.new params[:storage_item]
    issue = Issue.find params[:storage_item][:issue_id]
    @item.issue = issue
    @project = issue.project
    if @item.save
      redirect_to(storage_items_path(:project_id => @project.id))
    else
      render "new"
    end
  end

  def update
    item_params = params[:storage_item]
    issue = Issue.find item_params[:issue_id] if item_params[:issue_id]
    @project = issue.try(:project) || @item.issue.try(:project)
    if @item.update_attributes item_params
      redirect_to(storage_items_path(:project_id => @project.id))
    else
      render "edit"
    end
  end

  def destroy
    @project = @item.issue.try(:project)
    redirect_params = {:project_id => @project.id} if @project
    if not @item.destroy
      flash[:notice] = "Could not delete item"
    end
    redirect_to(storage_items_path(redirect_params))
  end

  protected

  def find_project
    @project = Project.find params[:project_id]
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_item
    @item = StorageItem.find params[:id]
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
