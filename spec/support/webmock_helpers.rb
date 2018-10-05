# frozen_string_literal: true

module WebMockHelpers
  def stub_custom_request(url:, body:, method: :get, status: 200)
    stub_request(method, url).to_return(body: body, status: status)
  end
end

RSpec.configure do |config|
  config.include WebMockHelpers, type: :job
  config.include WebMockHelpers, type: :feature
  config.include WebMockHelpers, type: :request
  config.include WebMockHelpers, type: :service
end
