class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller
  
  protect_from_forgery

  def ensure_authenticated
    if current_facebook_user.nil?
      redirect_to url_for(:controller => "login")
    else
      @current_user = User.find_or_create_by_facebook_id(current_facebook_user.id)
      current_facebook_user.fetch
      @feed = FbFeed.new(current_facebook_user)
      logger.debug( "user: #{ @current_user }")
    end
  end

end
