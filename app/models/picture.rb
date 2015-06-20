class Picture < ActiveRecord::Base
  belongs_to :attachable_image, polymorphic: true
  has_attached_file :image, :storage => :dropbox,
:dropbox_credentials => "#{Rails.root}/config/dropbox_config.yml",:styles => { :medium => "300x300>" },
:dropbox_options => {       
:path => proc { |style| "#{Rails.env}/#{style}/#{id}_#{picture.original_filename}"}, :unique_filename => true 
  }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  default_scope -> { order('created_at ASC') }
  def preview
    image.url
  end
end
