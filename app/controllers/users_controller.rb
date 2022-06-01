class UsersController < ApplicationController
    def create
      user = User.create!(user_params)

      auth_token = UserAuthenticator.new(user_params[:email], user_params[:password]).call  
      json_response({ auth_token: auth_token, message: 'Account created successfully!' }, 201)
    end 

    def destroy 
    end


    private 

    def user_params 
      params.permit(
                    :email,
                    :name,
                    :password, 
                    :password_confirmation
                   )
    end
end
