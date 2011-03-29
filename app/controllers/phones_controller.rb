class PhonesController < ApplicationController
  before_filter :ensure_authenticated

  def index
    @phones = @current_user.phones
  end
  
  def show
    @phone = @current_user.phones.find(params[:id])
  end
  
  def new
    @phone = Phone.new
  end

  def create
    @phone = Phone.new(params[:phone])
    add_user
    if @phone.save
      flash[:notice] = "Successfully created phone."
      redirect_to @phone
    else
      render :action => 'new'
    end
  end

  def edit
    @phone = @current_user.phones.find(params[:id])
  end

  def update
    @phone = @current_user.phones.find(params[:id])
    add_user
    if @phone.update_attributes(params[:phone])
      flash[:notice] = "Successfully updated phone."
      redirect_to @phone
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @phone = @current_user.phones.find(params[:id])
    @phone.destroy
    flash[:notice] = "Successfully destroyed phone."
    redirect_to phones_url
  end

  protected

  def add_user
    @phone.user = @current_user
  end

end
