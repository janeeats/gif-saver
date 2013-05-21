class Gif < ActiveRecord::Base
  attr_accessible :file_path, :folder_id

  belongs_to :folder
end
