require 'spec_helper'

describe SessionController do
  before do
    @user = FactoryGirl.create(:user)
  end
  it "should get new" do
    get :new
    expect(response.status).to eq(200)
  end
  it "should log user in" do
    post :create, name: @user.name, password: "pass"
    expect(response).to redirect_to admin_url
    expect(session[:user_id]).to eq(@user.id)
  end
  it "should fail log in" do
    post :create, name: @user.name, password: "wrong"
    expect(response).to redirect_to login_url
  end
  it "should log out" do
    delete :destroy
    expect(response).to redirect_to store_url
  end
end
