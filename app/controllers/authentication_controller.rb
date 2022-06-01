class AuthenticationController < ApplicationController
  def authenticate
    user = User.find_by(email: auth_params[:email])
    user = user&.authenticate(auth_params[:password])

    if user
      payload = { user_id: user.id, email: user.email }
      auth_token = JsonWebToken.encode(payload)
      json_response({ auth_token: auth_token, message: 'Logged In Successfully!' })
    else
      json_response({ message: 'Log in failed' }, 401) 
    end
  end


  private 

  def auth_params 
    params.permit(
        :email,
        :name,
        :password
    )
  end
end
