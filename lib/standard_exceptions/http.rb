module StandardExceptions::Http
  class BadRequest < StandardExceptions::Exception
    MESSAGE = 'The request was not processed due to a syntax error.'
    STATUS = 400
  end

  class Unauthorized < StandardExceptions::Exception
    MESSAGE = 'The request was not processed because it lacked acceptable authentication credentials.'
    STATUS = 401
  end

  class Forbidden < StandardExceptions::Exception
    MESSAGE = 'The server understood the request but refuses to authorize it.'
    STATUS = 403
  end

  class NotFound < StandardExceptions::Exception
    MESSAGE = 'The server did not find the requested resource.'
    STATUS = 404
  end

  # MethodNotAllowed	405
  # NotAcceptable	406
  # ProxyAuthenticationRequired	407
  # RequestTimeout	408
  # Conflict	409
  # Gone	410
  # LengthRequired	411
  # PreconditionFailed	412
  # RequestEntityTooLarge	413
  # RequestURITooLong	414
  # UnsupportedMediaType	415
  # RequestedRangeNotSatisfiable	416
  # ExpectationFailed	417

  class UnprocessableEntity < StandardExceptions::Exception
    MESSAGE = 'The server understands the request but was unable to process it.'
    STATUS = 422
  end

  # Locked	423
  # FailedDependency	424
  # UpgradeRequired	426

  class InternalServerError < StandardExceptions::Exception
    MESSAGE = 'The server encountered an unexpected condition that prevented it from fulfilling the request.'
    STATUS = 500
  end

  # class NotImplemented	501
  # class BadGateway	502
  # class ServiceUnavailable < Exception
  # 	STATUS = 503
  # end
  # GatewayTimeout	504
  # HTTPVersionNotSupported	505
  # InsufficientStorage	507
  # NotExtended	510
end
