namespace :scrape do
  # desc "scrapes articles from CNN"
  task articles: :environment do
    # CnnArticles.new
    HuffpostArticles.new
  end

end