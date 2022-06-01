module ExceptionHandlers
  extend ActiveSupport::Concern 

  class AuthenticationError < StandardError; end 
  class InvalidTokenError < StandardError; end 
  class MissingTokenError < StandardError; end
  class ExpiredTokenError < StandardError; end

  included do 
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ExceptionHandlers::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandlers::ExpiredTokenError, with: :unauthorized_request
    rescue_from ExceptionHandlers::InvalidTokenError, with: :invalid_record
    rescue_from ExceptionHandlers::MissingTokenError, with: :invalid_record
  end

  
  private 

  def unauthorized_request(e)
    render json: { message: e.message }, status: 401
  end

  def record_not_found(e)
    render json: { message: e.message }, status: 404
  end

  def invalid_record(e)
    render json: { message: e.message }, status: 422
  end
end