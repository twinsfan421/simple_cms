class PagesController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_subject
  before_action :find_subjects, :only => [:new, :create, :edit, :update]
  before_action :set_page_count, :only => [:edit, :update, :new, :create]

  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params['id'])
  end

  def new
    @page = Page.new(:subject_id => @subject.id)
  end

  def create
    # Instantiate a new object using form parameters
    @page = Page.new(page_params)
    # Save the object
    if @page.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Page created successfully."
      redirect_to(pages_path(:subject_id => @subject.id))
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end

  end
    

  def edit
    @page = Page.find(params['id']) 
    
  end

  def update
    # Instantiate a new object using form parameters
    @page = Page.find(params[:id])
    # Update the object
    if @page.update_attributes(page_params)
      # If save succeeds, redirect to the index action
      flash[:notice] = "Page updated successfully."
      redirect_to(page_path(@page, :subject_id => @subject.id))
    else
      # If save fails, redisplay the form so user can fix problems 
      render('edit')
    end
  end

  def delete
    @page = Page.find(params['id'])
  end

  def destroy
    @page = Page.find(params['id'])
    @page.destroy
    flash[:notice] = "Page deleted successfully."
    redirect_to(pages_path(:subject_id => @subject.id))
  end

  private

  def page_params
    params.require(:page).permit(:name, :subject_id, :permalink, :position, :visible)
  end

  def find_subject
    @subject = Subject.find(params[:subject_id])
  end

  def find_subjects
    @subjects = Subject.sorted
  end
  def set_page_count
    @page_count = @subject.pages.count 
    if params[:action] == 'new' || params[:acton] == 'create'
      @page_count += 1
    end
  end

end
