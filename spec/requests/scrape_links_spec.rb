# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ScrapeLinks', type: :request do
  describe 'POST /scrape_links' do
    let(:url) { 'https://example.com/links.html' }
    let(:body) { File.read("#{scraper_test_files_path}links.html") }
    let(:scrape_links_params) do
      { email: 'test@user.com', url: url }
    end

    before do
      stub_custom_request(url: url, body: body)
    end

    it 'generates links.txt file' do
      perform_enqueued_jobs do
        post scrape_links_path, params: scrape_links_params
        expect(File.exist?(storage_path)).to be_truthy
      end
    end

    it 'sends email' do
      perform_enqueued_jobs do
        post scrape_links_path, params: scrape_links_params
        expect(emails.last.to).to eq([scrape_links_params[:email]])
        expect(emails.last.subject).to eq('Scraped links results')
        expect(emails.last.from).to eq(['no-reply@example.com'])
      end
    end
  end
end
