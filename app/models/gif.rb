class Gif < ActiveRecord::Base

  attr_accessible :file, :folder_id, :file_remote_url, :caption

  validates :caption, :folder_id, :presence => true, :on => :create
  validates_presence_of :file, :unless => :file_remote_url?
  validates_presence_of :file_remote_url, :unless => :file?

  belongs_to :folder

  has_attached_file :file, :styles => { :thumb => "150x160#" }

  def slug
    caption.downcase.gsub(" ", "-").gsub("!", "").gsub("*", "")
  end

  def to_param
    "#{id}-#{slug}"
  end

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