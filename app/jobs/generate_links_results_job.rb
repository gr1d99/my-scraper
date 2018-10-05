# frozen_string_literal: true

class GenerateLinksResultsJob < ApplicationJob
  queue_as :default

  def perform(url:, email:)
    document = NokogiriService.call(url: url)
    links = LinksScraperService.call(doc: document)
    file_path = GenerateLinksResultsService.call(links: links)
    SendLinksResultsJob.perform_later(
      to: email,
      file_path: file_path
    )
  end
end
