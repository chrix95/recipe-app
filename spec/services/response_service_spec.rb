require 'rails_helper'

RSpec.describe ResponseService, type: :service do
  describe '.success_response' do
    it 'returns a success response' do
      data = { key: 'value' }
      response = ResponseService.success_response(data)

      expect(response[:status]).to eq(200)
      expect(response[:data]).to eq(data)
      expect(response[:meta][:timestamp]).to be_present
    end
  end

  describe '.failure_response' do
    it 'returns a failure response with custom error code' do
      status = 404
      message = 'Resource not found'
      details = { field: 'value' }
      response = ResponseService.failure_response(status, message, details)

      expect(response[:status]).to eq(status)
      expect(response[:error][:code]).to eq('NOT_FOUND')
      expect(response[:error][:message]).to eq(message)
      expect(response[:error][:details]).to eq(details)
      expect(response[:meta][:timestamp]).to be_present
    end

    it 'returns a failure response with default error code for unknown status' do
      status = 418
      message = 'I’m a teapot'
      response = ResponseService.failure_response(status, message)

      expect(response[:status]).to eq(status)
      expect(response[:error][:code]).to eq('UNKNOWN_ERROR')
      expect(response[:error][:message]).to eq(message)
      expect(response[:error][:details]).to be_empty
      expect(response[:meta][:timestamp]).to be_present
    end
  end

  describe '.generate_error_code' do
    it 'returns the correct error code for a given status' do
      expect(ResponseService.send(:generate_error_code, 400)).to eq('BAD_REQUEST')
      expect(ResponseService.send(:generate_error_code, 404)).to eq('NOT_FOUND')
      expect(ResponseService.send(:generate_error_code, 422)).to eq('VALIDATION_ERROR')
      expect(ResponseService.send(:generate_error_code, 500)).to eq('INTERNAL_SERVER_ERROR')
      expect(ResponseService.send(:generate_error_code, 418)).to eq('UNKNOWN_ERROR')
    end
  end
end
