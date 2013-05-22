class Gif < ActiveRecord::Base
  attr_accessible :file_path, :folder_id, :file

  belongs_to :folder

  has_attached_file :file, :styles => { :medium => "375x300>", :thumb => "100x80>" }, :default_url => "/assets/default.gif"
end
