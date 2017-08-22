module StandardExceptions::HttpMethods
  include ::StandardExceptions::Http
  module_function

  def unauthorized!(message=nil)
    raise Unauthorized.new(message)
  end

  def forbidden!(message=nil)
    raise Forbidden.new(message)
  end

  def not_found!(message=nil)
    raise NotFound.new(message)
  end

  def internal_server_error!(message=nil)
    raise InternalServerError.new(message)
  end
end
