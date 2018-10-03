# frozen_string_literal: true

module AttachmentsHelper
  def attachments_path
    Rails.root.join('spec/fixtures/')
  end
end

RSpec.configure do |config|
  config.include AttachmentsHelper, type: :mailer

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
