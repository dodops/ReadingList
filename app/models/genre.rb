class Genre < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :book_genres
  has_many :books, :through => :book_genres
end
