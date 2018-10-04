# frozen_string_literal: true

require 'rails_helper'

feature 'scraping links process' do
  let(:form_xpath) { ".//form[@name='links-scraper-form']" }

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
    within(:xpath, form_xpath) do
      fill_in('Email', with: 'test@example.com')
      fill_in('Url', with: 'localhost.com')
      click_on('fetch me all links')
    end

    expect(page).to have_content(
      'We will notify and send you all links via the email you provided shortly'
    )
  end
end
