class SessionsController < ApplicationController

  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by(provider: auth["provider"], uid: auth["uid"]) || User.create_with_facebook(auth)
    session[:user_id] = user.id
    redirect_back_or root_path
  end

end
