class UsersController < ApplicationController
    def create
      user = User.create!(user_params)
      render json: { user: user }, status: :ok
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
