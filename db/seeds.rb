# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Source.destroy_all
Article.destroy_all
User.destroy_all
Reading.destroy_all
Like.destroy_all
UserTag.destroy_all
Topic.destroy_all
Tag.destroy_all
ArticleTag.destroy_all

tables = [:articles, :sources, :users, :readings, :likes, :user_topics, :topics, :tags, :article_tags]

tables.each do |table|
  ActiveRecord::Base.connection.reset_pk_sequence!(table)
end

sources = [{ name: 'The Washington Post', api_url: "www.placeholder.com" }, { name: 'The New York Times', api_url: "www.placeholder.com" }, { name: 'CNN', api_url: "www.placeholder.com" },
{ name: 'Business Insider', api_url: "www.placeholder.com" }, { name: 'ESPN', api_url: "www.placeholder.com" }, { name: 'TechCrunch', api_url: "www.placeholder.com" }, { name: 'BBC', api_url: "www.placeholder.com" }, { name: 'The Huffington Post', api_url: "www.placeholder.com" },
{ name: 'The Guardian', api_url: "www.placeholder.com" }, { name: 'CNET', api_url: "www.placeholder.com" }]

sources.each do |source|
  Source.create!(source)
end

articles = Article.create!([{ title: 'Trump Stress-Tested the Election System, and the Cracks Showed', author: 'Alexander Burns', content_preview: 'As President Trump’s efforts to overturn the 2020 election have steadily disintegrated, the country appears to have escaped a doomsday scenario in the campaign’s epilogue: Since Nov. 3, there have been no tanks in the streets or widespread civil unrest...', read_mins: 4, article_url: 'https://www.nytimes.com/2020/11/24/us/politics/election-trump-democracy.html', source_id: 2  },
{ title: 'Covid-19 doesn’t care about the holidays. It’s more dangerous than ever.', author: 'Lucy Jones', content_preview: 'When the upcoming holidays inspire us to take more risks and let down our guard, we are not being resentful, stupid or selfish. We are being human. But covid-19 does not care that we perceive it to be less risky — it is more dangerous than ever.', read_mins: 9, article_url: 'https://www.washingtonpost.com/opinions/2020/11/24/covid-19-holiday-risk-dangerous/', source_id: 1 },
{ title: 'Utah helicopter crew discovers mysterious metal monolith deep in the desert', author: 'Leah Asmelash', content_preview: "What started as routine wildlife assistance took an extraterrestrial turn for Utah's Department of Public Safety after officers stumbled upon a mysterious monolith in the middle of rural Utah.", read_mins: 14, article_url: 'https://www.cnn.com/style/article/utah-monolith-art-trnd/index.html', source_id: 3 },
{ title: 'Stores are reducing Black Friday sales hours this year but experts says that could actually make shopping less safe', author: 'Mary Meisenzahl', content_preview: "The usual Black Friday experience of long lines on Thanksgiving and 3 a.m. store openings is sure to look different this year, as retailers roll out safety measures in-stores and move many sales online.", read_mins: 4, article_url: 'https://www.businessinsider.com/reduced-black-friday-hours-could-make-shopping-less-safe-2020-11', source_id: 4 },
{ title: "Jay Bilas introduces The Bilastrator's 2020-21 College Basketball Opus", author: 'Jay Bilas', content_preview: "The 2019-20 college basketball season ended unceremoniously, and in unprecedented fashion, as a global pandemic started. Never before, not even during times of war or other catastrophe, has the NCAA tournament been canceled or otherwise not played.", read_mins: 25, article_url: 'https://www.espn.com/mens-college-basketball/insider/story/_/id/30371934/jay-bilas-introduces-bilastrator-2020-21-college-basketball-opus', source_id: 5 }])

users = User.create!([{ email: "gennabartolucci@gmail.com", password:"Hello123", username: "gennalucci"  }, { email: "berlin.onumonu@gmail.com", password:"Hello123", username: "berlino"  }, { email: "romariosx202@hotmail.com", password:"Hello123", username: "romarios"  }])

# readings =
# likes =
# user_topics =

topics = Topic.create!([{ name: "technology" }, { name: "sports" }, { name: "politics" }, { name: "business" }, { name: "culture" }, { name: "lifestyle" }])


Tag.create!({ name: 'coding', topic_id: 1 })
Tag.create!({ name: 'computers', topic_id: 1 })
Tag.create!({ name: 'startups', topic_id: 1 })
Tag.create!({ name: 'green tech', topic_id: 1 })
Tag.create!({ name: 'artificial intelligence', topic_id: 1 })

Tag.create!({ name: 'football', topic_id: 2 })
Tag.create!({ name: 'soccer', topic_id: 2 })
Tag.create!({ name: 'basketball', topic_id: 2 })
Tag.create!({ name: 'fantasy football', topic_id: 2 })
Tag.create!({ name: 'college sports', topic_id: 2 })

Tag.create!({ name: '2020 election', topic_id: 3 })
Tag.create!({ name: 'covid-19', topic_id: 3 })
Tag.create!({ name: 'democratic party', topic_id: 3 })
Tag.create!({ name: 'republican party', topic_id: 3 })
Tag.create!({ name: 'middle east', topic_id: 3 })
Tag.create!({ name: "american", topic_id: 3 })

Tag.create!({ name: 'companies', topic_id: 4 })
Tag.create!({ name: 'international', topic_id: 4 })
Tag.create!({ name: 'financial', topic_id: 4 })
Tag.create!({ name: 'financial literacy', topic_id: 4 })
Tag.create!({ name: 'interest rates', topic_id: 4 })
Tag.create!({ name: "retail", topic_id: 4 })

Tag.create!({ name: 'books', topic_id: 5 })
Tag.create!({ name: 'TV & film', topic_id: 5 })
Tag.create!({ name: 'entertainment', topic_id: 5 })
Tag.create!({ name: 'travel', topic_id: 5 })

Tag.create!({ name: 'health', topic_id: 6 })
Tag.create!({ name: 'style & beauty', topic_id: 6 })
Tag.create!({ name: 'outdoor living', topic_id: 6 })
Tag.create!({ name: 'college', topic_id: 6 })


