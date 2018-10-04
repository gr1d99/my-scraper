# frozen_string_literal: true

class LinksMailer < ApplicationMailer
  default subject: 'Scraped links results'

  def send_results
    @to = params[:to]
    @filepath = params[:filepath]
    @filename = @filepath.split('/').last
    attachments[@filename] = File.read(@filepath)
    mail(to: @to)
  end
end
