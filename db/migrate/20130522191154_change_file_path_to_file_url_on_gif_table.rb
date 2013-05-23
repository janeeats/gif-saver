class ChangeFilePathToFileUrlOnGifTable < ActiveRecord::Migration
  def up
    add_column :gifs, :file_remote_url, :string
    remove_column :gifs, :file_path
  end

  def down
    remove_column :gifs, :file_remote_url
    add_column :gifs, :file_path, :string
  end
end
