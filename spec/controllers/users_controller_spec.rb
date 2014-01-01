require 'spec_helper'

describe UsersController do
  before do
    @valid_attrs = FactoryGirl.attributes_for(:user)
    @user = FactoryGirl.create(:user)
    login(@user)
  end
  it "should create user" do
    expect{post :create, user: @valid_attrs}.to change{User.count}.by(1)
    expect(response).to redirect_to users_path
  end
  it "should update user" do
    @valid_attrs[:old_password] = "pass"
    put :update, id: @user, user: @valid_attrs
    expect(response).to redirect_to users_path
  end
  it "should not update when not logged in" do
    logout
    put :update, id: @user, user: @valid_attrs
    expect(response).to redirect_to login_path
  end
end
