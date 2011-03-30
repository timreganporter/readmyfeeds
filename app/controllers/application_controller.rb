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
        @user = Phone.find_by_number(phone).try(:user)
        unless @user
          redirect_to url_for(:controller => "login", :action => "not_found", :format => :xml)
          return
        end
        offline_client = Mogli::Client.new(@user.facebook_access_token, nil)
        fb_user = Mogli::User.find(@user.facebook_id, offline_client) # reusing current_facebook_user breaks use in else, somehow
      else
        @user = User.find_or_create_by_facebook_id(current_facebook_user.id)
        #not the best place, but ...
        set_access_token
        current_facebook_user.fetch
      end
      @feed = FbFeed.new(@user)
      logger.debug("twilio, #{ @feed }")
      logger.debug("url = https://graph.facebook.com/#{ @user.facebook_id }/home?access_token=#{ @user.facebook_access_token }")
    end
  end

  protected

  def set_access_token
    if (@user.facebook_access_token != current_facebook_client.access_token)
      @user.facebook_access_token = current_facebook_client.access_token
      @user.save
    end
  end

end
