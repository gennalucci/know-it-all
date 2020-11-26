class Topic < ApplicationRecord
  has_many :tags, dependent: :destroy
end
