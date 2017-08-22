module StandardExceptions::ApplicationMethods
  include ::StandardExceptions::Application
  module_function

  def validation_failed!(message=nil)
    raise ValidationFailed.new(message)
  end

  def failed!(message=nil)
    raise Failed.new(message)
  end
end
