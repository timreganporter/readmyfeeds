class FeedsController < ApplicationController

  before_filter :ensure_authenticated

  # Welcome screen.
  def index
    @phones = @current_user.phones
    @posts = @feed.posts #.slice(0..9)
  end

end