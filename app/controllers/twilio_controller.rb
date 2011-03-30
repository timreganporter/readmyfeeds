class TwilioController < ApplicationController
  before_filter :ensure_authenticated

  def index
    @gather_action = "/twilio/index.xml"
    respond_to do |format|
      format.xml
    end
  end


end