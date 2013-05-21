class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.integer :folder_id
      t.string :file_path

      t.timestamps
    end
  end
end
