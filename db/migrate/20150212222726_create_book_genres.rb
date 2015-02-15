class CreateBookGenres < ActiveRecord::Migration
  def change
    create_table :book_genres do |t|
      t.references :book, index: true
      t.references :genre, index: true

      t.timestamps null: false
    end
    add_foreign_key :book_genres, :books
    add_foreign_key :book_genres, :genres
  end
end
