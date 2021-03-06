require 'open-uri'
# Run anytime you want to seed the DB with articles for a user. Then you're ready to query the DB for the most recently created articles matching that user's read time and tags.
class CnnArticles
  def initialize
    @source = Source.find_by_name("CNN")
    Tag.all.each do |tag|
      rss_url = tag_rss_url_lookup[tag.name]
      if rss_url
        create_articles_from_rss_feed_url(rss_url, tag)
      end
    end
  end

  def create_articles_from_rss_feed_url(rss_feed_url, tag)
    xml = open(rss_feed_url)
    doc = Nokogiri::XML(xml)
    items = doc.xpath('//item').first(ENV.fetch("ARTICLE_SCRAPE_QUANTITY") { 10 })
    number_of_items = items.count
    number_of_items.times do |i|
      title =  doc.xpath("//item[#{i+1}]/title").text
      content_preview = doc.xpath("//item[#{i+1}]/description").text
      content_preview_cleaned = Nokogiri::HTML(content_preview).text.strip.gsub("• ","").gsub("\n","")
      article_url = doc.xpath("//item[#{i+1}]/link").text
      # image_url = doc.xpath("//item[#{i+1}]/media:thumbnail").first&.attributes&.[]("url")&.value


      begin
        html = open(article_url)
        words_per_min = 200
        article_doc = Nokogiri::HTML(html)
        image_url = article_doc.search("meta[property='og:image']").first&.attributes&.[]("content")&.value
        read_mins = article_doc.search(".zn-body__paragraph").text.split.count / words_per_min
        article_hash = {
          title: title, content_preview: content_preview_cleaned, article_url: article_url, read_mins: read_mins, source: @source, image_url: image_url
        }
        # p article_hash

        article =  Article.create(article_hash)

        if article.persisted?
          ArticleTag.create(tag: tag, article: article)
        end
        p article.attributes
      rescue OpenURI::HTTPError
        puts article_url
      end
    end
  end
  private
  def tag_rss_url_lookup
    {
      "companies" => "http://rss.cnn.com/rss/money_news_companies.rss",
      "international" => "http://rss.cnn.com/rss/money_news_international.rss",
      "financial" => "http://rss.cnn.com/rss/money_latest.rss",
      "health" => "http://rss.cnn.com/rss/cnn_health.rss",
      "entertainment" => "http://rss.cnn.com/rss/cnn_showbiz.rss",
      "travel" => "http://rss.cnn.com/rss/cnn_travel.rss",
    }
    # "http://rss.cnn.com/rss/money_topstories.rss",
    # "http://rss.cnn.com/rss/money_mostpopular.rss",
    # "http://rss.cnn.com/rss/money_news_economy.rss",
    # "http://rss.cnn.com/rss/money_video_business.rss",
    # "http://rss.cnn.com/rss/money_media.rss",
    # "http://rss.cnn.com/rss/money_markets.rss",
    # "http://rss.cnn.com/cnnmoneymorningbuzz",
    # "http://rss.cnn.com/rss/money_technology.rss",
    # "http://rss.cnn.com/rss/money_pf.rss",
    # "http://rss.cnn.com/rss/money_autos.rss",
    # "http://rss.cnn.com/rss/money_funds.rss",
    # "http://rss.cnn.com/rss/money_pf_college.rss",
    # "http://rss.cnn.com/rss/money_pf_insurance.rss",
    # "http://rss.cnn.com/rss/money_pf_taxes.rss",
    # "http://rss.cnn.com/rss/money_retirement.rss",
    # "http://rss.cnn.com/rss/money_lifestyle.rss",
    # "http://rss.cnn.com/rss/money_realestate.rss",
    # "http://rss.cnn.com/rss/money_luxury.rss",
    # "http://rss.cnn.com/rss/money_smbusiness.rss"
  end
end
