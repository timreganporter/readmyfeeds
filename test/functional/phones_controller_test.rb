require 'test_helper'

class PhonesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Phone.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Phone.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Phone.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to phone_url(assigns(:phone))
  end
  
  def test_edit
    get :edit, :id => Phone.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Phone.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Phone.first
    assert_template 'edit'
  end

  def test_update_valid
    Phone.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Phone.first
    assert_redirected_to phone_url(assigns(:phone))
  end
  
  def test_destroy
    phone = Phone.first
    delete :destroy, :id => phone
    assert_redirected_to phones_url
    assert !Phone.exists?(phone.id)
  end
end
