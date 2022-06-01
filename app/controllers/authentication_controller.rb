class AuthenticationController < ApplicationController
  def authenticate
    auth_token = UserAuthenticator.new(auth_params[:email], auth_params[:password]).call
    json_response({ auth_token: auth_token, message: 'Logged In Successfully!' })
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
