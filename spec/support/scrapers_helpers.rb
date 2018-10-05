# frozen_string_literal: true

module ScraperHelper
  STORAGE_PATH = Rails.root.join('public/links/')

  def scraper_test_files_path
    Rails.root.join('spec/fixtures/html_files/')
  end

  def storage_path
    STORAGE_PATH
  end

  def clear_storage_path
    FileUtils.remove_dir(storage_path, true)
  end
end

RSpec.configure do |config|
  config.include ScraperHelper, type: :feature
  config.include ScraperHelper, type: :job
  config.include ScraperHelper, type: :request
  config.include ScraperHelper, type: :service

  config.before(:each) do
    if File.exist?(Rails.root.join('public/links/'))
      FileUtils.remove_dir(ScraperHelper::STORAGE_PATH, true)
    end
  end

  config.after(:each) do
    if File.exist?(Rails.root.join('public/links/'))
      FileUtils.remove_dir(ScraperHelper::STORAGE_PATH, true)
    end
  end
end
