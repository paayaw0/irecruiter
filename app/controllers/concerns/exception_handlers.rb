module ExceptionHandlers
  extend ActiveSupport::Concern 

  included do 
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  end
  
  
  private 

  def invalid_record(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end
end