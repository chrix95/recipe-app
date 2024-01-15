class ResponseService
  def self.success_response(data)
    {
      status: 200,
      data: data,
      meta: { # use case might be different
        timestamp: Time.now.utc.iso8601
      }
    }
  end

  def self.failure_response(status, message, details = {})
    error_code = generate_error_code(status)

    {
      status: status,
      error: {
        code: error_code,
        message: message,
        details: details
      },
      meta: {
        timestamp: Time.now.utc.iso8601
      }
    }
  end

  private

  def self.generate_error_code(status)
    case status
      when 400
        "BAD_REQUEST"
      when 404
        "NOT_FOUND"
      when 500
        "INTERNAL_SERVER_ERROR"
      else
        "UNKNOWN_ERROR"
    end
  end
end
