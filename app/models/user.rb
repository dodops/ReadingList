class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions
  has_many :books, :through => :subscriptions
  #scope :subs, ->(abok) { joins(:subscriptions).where('book_id = ?', abok.id) }

  def subscribe(abook)
    subscriptions.create(book: abook)
  end

  def unsubscribe(abook)
    subscriptions.find_by(book: abook).destroy
  end

  def subscribed?(abook)
    books.include?(abook)
  end
end
