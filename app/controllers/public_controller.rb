class PublicController < ApplicationController

  before_action :setup_navigation


  layout 'public'

  def index
  	#intro text
  end

  def show
  	@page = Page.visible.where(:permalink => params[:permalink]).first
  	if @page.nil?
  	  redirect_to(root_path)
  	end
  end

  private

  def setup_navigation
    @subjects = Subject.visible.sorted
  end
  
end
