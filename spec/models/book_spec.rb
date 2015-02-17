require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryGirl.create(:book) }
  let(:params) { { title: "asas", author: "asasa", description: "asas", finished_on: 2.days.ago } }

  describe ".finished" do
    it "should return only the finished books" do
      finished_book = Book.create(params)
      expect(described_class.finished).to_not include(book)
      expect(described_class.finished).to include(finished_book)
    end
  end

  describe ".genre_filter" do
    it "should return books of a particular genre" do
      book.update(genres: [FactoryGirl.create(:genre)])
      genre = book.genres.first
      expect(described_class.genre_filter(2)).to_not include(book)
      expect(described_class.genre_filter(genre)).to include(book)
    end
  end

  describe ".search" do
    it "should return books based on the params informed" do
      expect(described_class.search("MYSTRIN")).to include(book)   
    end
  end

  describe "#finished?" do
    it "true if a book is finished" do
      expect(book.finished?).to be_falsey
    end
  end
  
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:description) }
  it { should have_many(:book_genres) }
  it { should have_many(:genres).through(:book_genres) }
end
