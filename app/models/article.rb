class Article < ApplicationRecord
  belongs_to :source
  validates :title, uniqueness: true
  has_many :article_tags, dependent: :destroy
end
