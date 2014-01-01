module SpecTestHelper
  def login_admin
    login(:admin)
  end
  
  def login(user)
    user = User.find_by_name(user.to_s) if user.is_a?(Symbol)
    request.session[:user_id] = user.id
  end
  
  def current_user
    User.find(request.session[:user_id])
  end
  
  def logout
    request.session[:user_id] = nil
  end
end
