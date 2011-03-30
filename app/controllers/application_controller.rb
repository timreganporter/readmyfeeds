class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller
  
  protect_from_forgery

  # TODO: needs major refactoring
  def ensure_authenticated
    if current_facebook_user.nil? && params[:Caller].blank?
      redirect_to url_for(:controller => "login")
    else
      if params[:Caller]
        phone = params[:Caller].match(/(\d){10}$/)[0]
        @current_user = Phone.find_by_number(phone).user
        offline_client = Mogli::Client.new(@current_user.facebook_access_token, nil)
        fb_user = Mogli::User.find(@current_user.facebook_id, offline_client) # reusing current_facebook_user breaks use in else, somehow
        @feed = FbFeed.new(fb_user)
      else
        @current_user = User.find_or_create_by_facebook_id(current_facebook_user.id)
        current_facebook_user.fetch
        @feed = FbFeed.new(current_facebook_user)
      end
      logger.debug( "user: #{ @current_user }")
    end
  end

end
