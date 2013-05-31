class AddSlugToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :slug, :string
    add_index :folders, :slug
  end
end
