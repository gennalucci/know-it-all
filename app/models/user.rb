class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :readings, dependent: :destroy
  has_many :articles, through: :readings
  has_many :likes, dependent: :destroy
  has_many :user_topics, dependent: :destroy
  has_many :topics, through: :user_topics
  has_many :tags, through: :topics

end
