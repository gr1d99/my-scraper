# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NokogiriService, type: :service do
  describe '.call' do
    let(:valid_file) { File.read("#{scraper_test_files_path}links.html") }

    it 'returns a fragment document'do
      stub_custom_request(
        url: 'http://example.com/links.html',
        body: valid_file
      )
      document = described_class.call(url: 'http://example.com/links.html')
      expect(document).to be_a_kind_of(Nokogiri::HTML::DocumentFragment)
    end
  end
end
