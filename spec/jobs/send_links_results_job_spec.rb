# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendLinksResultsJob, type: :job do
  let(:test_file) { "#{scraper_test_files_path.split[0]}/sample_links.txt" }
  let(:job) do
    described_class.perform_later(to: 'test@email.com', file_path: test_file)
  end

  it 'queues 1 job only' do
    expect { job }.to change(enqueued_jobs, :size).by(1)
  end

  it 'queues job' do
    expect { job }.to have_enqueued_job(described_class)
  end

  it 'sends email' do
    perform_enqueued_jobs do
      job
      expect(emails.size).to eq(1)
      expect(emails.last.to).to eq(['test@email.com'])
      expect(emails.last.subject).to eq('Scraped links results')
      expect(emails.last.from).to eq(['no-reply@example.com'])
    end
  end
end
