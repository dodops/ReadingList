require 'rails_helper'

RSpec.describe Genre, type: :model do
  it { is_expected.to have_many :books }
  it { is_expected.to have_many :book_genres }
end
