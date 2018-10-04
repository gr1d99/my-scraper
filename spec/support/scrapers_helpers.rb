# frozen_string_literal: true

module ScraperHelper
  def scraper_test_files_path
    Rails.root.join('spec/fixtures/html_files/')
  end
end

RSpec.configure do |config|
  config.include ScraperHelper, type: :service
end
