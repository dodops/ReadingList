class AddSlugToGenre < ActiveRecord::Migration
  def change
    add_column :genres, :slug, :string, index: true
  end
end
