class StorageItemsController < ApplicationController
  unloadable

  before_filter :find_project, :only => [:index, :new]
  before_filter :find_item, :only => [:show, :edit, :update, :delete]

  def index
    @items = StorageItem.joins(:issue => [:project]).where("projects.id" => @project.id)
  end

  def show
    @project = @item.issue.try(:project)
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
      head 400                  #  FIXME:
    end
  end

  def update
    if @item.update(params[:storage_item])
      head 200                  #  FIXME:
    end
  end

  def destroy
    if @item.destroy
      head 200                  #  FIXME:
    end
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
