module StandardExceptions::Application
  class Failed < ::StandardExceptions::Http::UnprocessableEntity
    MESSAGE = 'The requested operation was not successful.'
  end

  class ValidationFailed < Failed
    MESSAGE = 'The requested operation was not successful due to validation errors.'
    attr_writer :errors
    def errors
      @errors or inner && inner.respond_to?(:errors) && inner.errors
    end
  end
end
