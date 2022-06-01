class User < ApplicationRecord
    has_secure_password
    
    validates :email, :name, :password_digest, presence: :true
end
