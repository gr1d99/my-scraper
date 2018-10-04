# frozen_string_literal: true

class ScrapeController < ApplicationController
  def scrape_links
    flash['message'] =
      'We will notify and send you all links via the email you provided shortly'
    redirect_to root_path
  end

  private

  def link_params
    params.permit(:email, :url)
  end
end
