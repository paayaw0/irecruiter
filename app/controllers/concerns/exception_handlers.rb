module ExceptionHandlers
  extend ActiveSupport::Concern 

  class AuthenticationError < StandardError; end 
  class InvalidTokenError < StandardError; end 
  class MissingTokenError < StandardError; end

  included do 
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  end

  
  private 

  def invalid_record(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end
end