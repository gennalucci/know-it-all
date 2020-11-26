class Tag < ApplicationRecord
  belongs_to :topic
  has_many :user_tags, dependent: :destroy
end
