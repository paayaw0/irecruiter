module ControllerHelpers 
  def json
    body = JSON.parse(response.body)
    HashWithIndifferentAccess.new(body).deep_stringify_keys
  end
end