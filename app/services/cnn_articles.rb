require 'open-uri'

# Run anytime you want to seed the DB with articles for a user. Then you're ready to query the DB for the most recently created articles matching that user's read time and tags.

class CnnArticles

  def initialize(user, user_max_read_mins)
    @source = Source.find_by_name("CNN")
    user.tags.each do |tag|
      rss_url = tag_rss_url_lookup[tag.name]
      if rss_url
        create_articles_from_rss_feed_url(rss_url, user_max_read_mins, tag)
      end
    end
  end

  def create_articles_from_rss_feed_url(rss_feed_url, user_max_read_mins, tag)
    xml = open(rss_feed_url)
    doc = Nokogiri::XML(xml)
    items = doc.xpath('//item').first(4)
    number_of_items = items.count
    number_of_items.times do |i|
      title =  doc.xpath("//item[#{i+1}]/title").text
      content_preview = doc.xpath("//item[#{i+1}]/description").text
      content_preview_cleaned = Nokogiri::HTML(content_preview).text.strip.gsub("• ","").gsub("\n","")
      article_url = doc.xpath("//item[#{i+1}]/link").text
      begin
        html = open(article_url)
        words_per_min = 200
        article_doc = Nokogiri::HTML(html)
        read_mins = article_doc.search(".zn-body__paragraph").text.split.count / words_per_min

        article_hash = {
          title: title, content_preview: content_preview_cleaned, article_url: article_url, read_mins: read_mins, source: @source
        }
        # p article_hash
        if user_max_read_mins >= read_mins
          article =  Article.create(article_hash)

          if article.persisted?
            ArticleTag.create(tag: tag, article: article)
          end
          p article.attributes
        end
      rescue OpenURI::HTTPError
        puts article_url
      end
    end
  end
  private
  def tag_rss_url_lookup
    {
      "Companies" => "http://rss.cnn.com/rss/money_news_companies.rss",
      "International" => "http://rss.cnn.com/rss/money_news_international.rss",
      "Financial" => "http://rss.cnn.com/rss/money_latest.rss",
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