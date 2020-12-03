require 'open-uri'
# Run anytime you want to seed the DB with articles for a user. Then you're ready to query the DB for the most recently created articles matching that user's read time and tags.
class HuffpostArticles
  def initialize
    @source = Source.find_by_name("Huffington Post")
    Tag.all.each do |tag|
      rss_url = tag_rss_url_lookup[tag.name]
      if rss_url
        create_articles_from_rss_feed_url(rss_url, tag)
      end
    end
  end

  def create_articles_from_rss_feed_url(rss_feed_url, tag)
    begin
      xml = open(rss_feed_url)
      doc = Nokogiri::XML(xml)
      items = doc.xpath('//item').first(ENV.fetch("ARTICLE_SCRAPE_QUANTITY") { 10 })
      number_of_items = items.count
      number_of_items.times do |i|
        title =  doc.xpath("//item[#{i + 1}]/title").text.strip
        content_preview = doc.xpath("//item[#{i + 1}]/description").text.strip
        # content_preview_cleaned = Nokogiri::HTML(content_preview).text.strip.gsub("• ","").gsub("\n","")
        article_url = doc.xpath("//item[#{i + 1}]/link").text

        html = open(article_url, 'Accept-Encoding' => "")
        words_per_min = 200
        article_doc = Nokogiri::HTML(html)
        image_url = article_doc.search("meta[property='og:image']").first&.attributes&.[]("content")&.value
        read_mins = article_doc.search(".content-list-component.text").text.split.count / words_per_min
        article_hash = {
          title: title, content_preview: content_preview, article_url: article_url, read_mins: read_mins, source: @source, image_url: image_url
        }
        # p article_hash

        article =  Article.create(article_hash)

        if article.persisted?
          ArticleTag.create(tag: tag, article: article)
        end
        p article.attributes
      rescue StandardError => e
        puts "Rescued: #{e.inspect}"
      end
    end
  end
  private
  def tag_rss_url_lookup
    {
      "books" => "https://www.huffpost.com/section/books/feed",
      "TV & film" => "https://www.huffpost.com/section/tv/feed",
      "style & beauty" => "https://www.huffpost.com/section/style/feed",
      "coding" => "https://www.huffpost.com/topic/code-for-america/feed",
      "computers" => "https://www.huffpost.com/topic/computers/feed",
      "startups" => "https://www.huffpost.com/topic/startups/feed",
      "green tech" => "https://www.huffpost.com/topic/green-technology/feed",
      "artificial intelligence" => "https://www.huffpost.com/topic/artificial-intelligence/feed",
      "football" => "https://www.huffpost.com/topic/football/feed",
      "fantasy football" => "https://www.huffpost.com/topic/fantasy-football/feed",
      "soccer" => "https://www.huffpost.com/topic/football/feed",
      "basketball" => "https://www.huffpost.com/topic/basketball/feed",
      "college sports" => "https://www.huffpost.com/topic/college-sports/feed",
      "2020 election" => "https://www.huffpost.com/topic/2020-election/feed",
      "democratic party" => "https://www.huffpost.com/topic/democratic-party/feed",
      "republican party" => "https://www.huffpost.com/topic/republican-party/feed",
      "covid-19" => "https://www.huffpost.com/topic/covid-19/feed",
      "financial literacy" => "https://www.huffpost.com/topic/financial-literacy/feed",
      "interest rates" => "https://www.huffpost.com/topic/interest-rates/feed",
      "middle east" => "https://www.huffpost.com/topic/middle-east/feed",
      "outdoor living" => "https://www.huffpost.com/topic/outdoor-living-buying-guide/feed",
      "college" => "https://www.huffpost.com/topic/college/feed"

    }

  end
end
