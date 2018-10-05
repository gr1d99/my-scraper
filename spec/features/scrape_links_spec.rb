# frozen_string_literal: true

require 'rails_helper'

feature 'scraping links process' do
  let(:form_xpath) { ".//form[@name='links-scraper-form']" }
  let(:url) { 'https://example.com/links.html' }
  let(:body) { File.read("#{scraper_test_files_path}links.html") }

  before { visit(root_path) }

  scenario 'user sees link scraper form' do
    expect(page).to have_selector(:xpath, form_xpath)
    within(:xpath, form_xpath) do
      expect(page).to have_selector(:xpath, ".//input[@name='email']")
      expect(page).to have_selector(:xpath, ".//input[@name='url']")
      expect(page).to have_selector(
        :xpath, ".//input[@value='fetch me all links']"
      )
    end
  end

  scenario 'user submits links scraping request' do
    perform_enqueued_jobs do
      stub_custom_request(url: url, body: body)

      within(:xpath, form_xpath) do
        fill_in('Email', with: 'test@example.com')
        fill_in('Url', with: url)
        click_on('fetch me all links')
      end

      expect(page).to have_content(
        'We will notify and send you all links via the email you provided shortly'
      )
    end
  end
end
