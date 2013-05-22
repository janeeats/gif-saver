class AddFileColumnsToGifs < ActiveRecord::Migration

  def up
    add_attachment :gifs, :file
  end

  def down
    remove_attachment :gifs, :file
  end

end
