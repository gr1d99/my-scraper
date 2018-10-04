# frozen_string_literal: true

module AttachmentsHelper
  def attachments_path
    Rails.root.join('spec/fixtures/')
  end

  def emails
    ActionMailer::Base.deliveries
  end
end

RSpec.configure do |config|
  config.include AttachmentsHelper, type: :job
  config.include AttachmentsHelper, type: :mailer
  config.include AttachmentsHelper, type: :request

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
