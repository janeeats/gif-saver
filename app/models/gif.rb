require 'open-uri'

class Gif < ActiveRecord::Base

  attr_accessible :file, :folder_id, :file_remote_url

  has_attached_file :file, :styles => { :medium => "375x300>", :thumb => "100x80>" }, :default_url => "/assets/default.gif"

  belongs_to :folder

  def file_url_provided?
    !self.file_remote_url.blank?
  end
  
  def download_remote_gif(file_remote_url)
    if file_url_provided?
      self.file = open(URI.parse(file_remote_url)) 
      self.file_file_name = parse_url_for_name
    else
      # => do nothing
    end
  end

  def parse_url_for_name
    self.file_remote_url.split("/").last
  end

end