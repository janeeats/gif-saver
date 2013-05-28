class Gif < ActiveRecord::Base

  attr_accessible :file, :folder_id, :file_remote_url, :caption

  belongs_to :folder

  has_attached_file :file, :styles => { :thumb => "150x160#" }

  def file_url_provided?
    !self.file_remote_url.blank?
  end
  
  def download_remote_gif(file_remote_url)
    if file_url_provided?
      self.file = URI.parse(file_remote_url)
      self.file_file_name = parse_url_for_name
    else
      # => do nothing
    end
  end

  def parse_url_for_name
    self.file_remote_url.split("/").last
  end

  def post_to_facebook(user, caption)
    user.facebook.put_wall_post(caption , {:link => self.file.url})
  end

end