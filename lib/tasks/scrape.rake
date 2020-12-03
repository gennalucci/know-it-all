namespace :scrape do
  # desc "scrapes articles from CNN"
  task articles: :environment do
    HuffpostArticles.new
    CnnArticles.new
  end

end