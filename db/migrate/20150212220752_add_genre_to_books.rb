class AddGenreToBooks < ActiveRecord::Migration
  def change
    add_reference :books, :genre, index: true
    add_foreign_key :books, :genres
  end
end
