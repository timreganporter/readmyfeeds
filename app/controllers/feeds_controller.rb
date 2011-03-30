class FeedsController < ApplicationController

  before_filter :ensure_authenticated

  # Welcome screen.
  def index
    @phones = @current_user.phones
    @posts = @feed.posts #.slice(0..9)
    #not the best place, but ... this is root controller, which is where fb login redirects
    set_access_token
  end

  protected

  def set_access_token
    if (@current_user.facebook_access_token != current_facebook_client.access_token)
      @current_user.facebook_access_token = current_facebook_client.access_token
      @current_user.save
    end
  end

end