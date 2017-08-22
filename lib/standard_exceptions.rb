# copyright: buzzware/standard_exceptions
#
module StandardExceptions
  module ExceptionInterface
    def self.included(aClass)
      aClass.send :extend, ClassMethods
    end

    module ClassMethods
      # eg. 'Not Found'
      def human_name(e_class=self)
        i = e_class.name.rindex('::')
        base_name = e_class.name[(i+2)..-1]
        base_name.split(/(?=[A-Z])/).join(' ')
      end
    end

    attr_accessor :status

    attr_writer :inner
    def inner
      @inner || self.cause
    end

    def human_name
      self.class.human_name
    end
  end

  # messages are based on http://httpstatuses.com

  class Exception < ::StandardError
    MESSAGE = 'An error occurred that could not be identified'
    STATUS = 500

    include ExceptionInterface

    def initialize(message=nil,status=nil,inner=nil)
      super(message || self.class::MESSAGE)
      @status = (status || self.class::STATUS)
      @inner = inner
    end
  end
end

require 'standard_exceptions/http'
require 'standard_exceptions/application'
require 'standard_exceptions/http_methods'
require 'standard_exceptions/application_methods'

module StandardExceptions::Methods
  include StandardExceptions::HttpMethods
  include StandardExceptions::ApplicationMethods
end
