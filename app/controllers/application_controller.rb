class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_filter :tag_cloud, :tag

  def tag_cloud
      @tags = Item.tag_counts_on(:tags).order('counts DESC')
  end

  def tag
    @items = Item.tagged_with(params[:tag_name])
  end

end
