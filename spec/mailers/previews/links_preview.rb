# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/links
class LinksPreview < ActionMailer::Preview
  def send_results
    p "#{Rails.root.join('spec/fixtures/')}sample_links.txt"

    LinksMailer.with(
      to: 'test_user@example.com',
      filepath: "#{Rails.root.join('spec/fixtures/')}sample_links.txt"
    ).send_results
  end
end
