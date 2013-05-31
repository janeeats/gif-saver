class AddSlugToGifs < ActiveRecord::Migration
  def change
    add_column :gifs, :slug, :string
    add_index :gifs, :slug
  end
end
