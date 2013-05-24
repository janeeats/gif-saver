class AddCaptionToGifs < ActiveRecord::Migration
  def change
    add_column :gifs, :caption, :string
  end
end
