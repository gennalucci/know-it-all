class Article < ApplicationRecord
  belongs_to :source
  validates :title, uniqueness: true
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :likes, dependent: :destroy

  # scope :filter_articles_by_topic, ->(topic) { joins(:tags).where(tags: {topic_id: topic.id}) }
  scope :filter_articles_by_topic, ->(topic, time) { joins(:tags).where(tags: {topic_id: topic.id}).where("read_mins < ?", time) }
  DEFAULT_META = YAML.load_file(Rails.root.join("config/meta.yml"))
end
