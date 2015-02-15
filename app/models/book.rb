class Book < ActiveRecord::Base
  has_many :book_genres
  has_many :genres, :through => :book_genres

  scope :finished, -> { where.not(finished_on: nil) }
  scope :genre_filter, ->(genre_id) { joins(:genres).where('genres.id = ?', genre_id) }
  scope :search, ->(keyword){ where('keywords LIKE ?', "%#{I18n.transliterate(keyword.downcase)}%") if keyword.present? }

  validates :title, :author, :description, presence: true

  before_save :set_keywords


  def finished?
    finished_on.present?
  end

  protected

  def set_keywords
    keywords = [title, author, description].map(&:downcase).join(' ')
    self.keywords = I18n.transliterate(keywords)
  end
end
