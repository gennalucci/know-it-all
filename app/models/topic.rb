class Topic < ApplicationRecord
  has_many :tags, dependent: :destroy
  has_many :user_topics, dependent: :destroy
end
