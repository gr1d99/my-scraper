# frozen_string_literal: true

class ScrapeController < ApplicationController
  def scrape_links
    GenerateLinksResultsJob.perform_later(
      url: link_params[:url],
      email: link_params[:email]
    )
    flash['message'] =
      'We will notify and send you all links via the email you provided shortly'

    redirect_to root_path
  end

  private

  def link_params
    params.permit(:email, :url)
  end
end
