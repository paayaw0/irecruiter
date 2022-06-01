class UserAuthenticator
  def initialize(email, password)
    @email = email 
    @password = password
  end

  def call
    JsonWebToken.encode({ user_id: user.id, email: user.email }) if user 
  end

  
  private 
  attr_reader :email, :password

  def user
    user = User.find_by(email: email)
    user = user&.authenticate(password)
    return user if user 
    raise ExceptionHandlers::AuthenticationError, 'Invalid credentials'
  end
end