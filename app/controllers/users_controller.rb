class UsersController < ApplicationController
    def create
      user = User.create!(user_params)

      # authenticate user
      user = user&.authenticate(user_params[:password])

      payload = { user_id: user.id, email: user.email }
      auth_token = JsonWebToken.encode(payload)
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
