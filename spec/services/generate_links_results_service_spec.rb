# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenerateLinksResultsService, type: :service do
  describe '.call' do
    let(:url) { 'http://example.com/links.html' }
    let(:body) { File.read("#{scraper_test_files_path}links.html") }

    it 'generates text file' do
      stub_custom_request(url: url, body: body)
      document = NokogiriService.call(url: url)
      links = LinksScraperService.call(doc: document)
      links_file = described_class.call(links: links)
      expect(File.exist?(links_file)).to be_truthy
    end
  end
end
