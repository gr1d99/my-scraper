Rails.application.routes.draw do
  root to: 'welcome#index'
  post '/scrape-links', to: 'scrape#scrape_links'
end
