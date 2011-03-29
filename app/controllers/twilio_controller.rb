class TwilioController < ApplicationController
  before_filter :ensure_authenticated

  def index
    respond_to do |format|
      format.xml
    end
  end


end