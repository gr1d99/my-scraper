# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinksMailer, type: :mailer do
  describe '.send_results' do
    let(:filepath) { "#{attachments_path}sample_links.txt" }
    let(:mail) do
      described_class.with(
        to: 'test_user@example.com',
        filepath: filepath).send_results.deliver
    end
    let(:attachments) { mail.attachments }

    it 'renders the headers' do
      expect(mail.subject).to eq('Scraped links results')
      expect(mail.to).to eq(['test_user@example.com'])
      expect(mail.from).to eq(['test_admin@example.com'])
    end

    it 'renders body' do
      expect(mail.body.encoded)
        .to match(/Here is an attachment of the links you requested/)
    end

    it 'contains 1 attachment' do
      expect(attachments.size).to eq(1)
    end

    it 'has correct kind' do
      expect(attachments[0]).to be_a_kind_of(Mail::Part)
    end

    it 'has correct name' do
      expect(attachments[0].filename).to eq('sample_links.txt')
    end
  end
end
