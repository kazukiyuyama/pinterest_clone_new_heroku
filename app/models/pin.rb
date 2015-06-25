class Pin < ActiveRecord::Base
  acts_as_votable
  acts_as_commontable

  belongs_to :user
  has_many :images, as: :attachable_image, dependent: :destroy, class_name: 'Picture'

  CATEGORY = {
               'Electricity' => 'Electricity',
               'Cloths' => 'Cloths',
               'Cosmetics' => 'Cosmetics',
               'Foods' => 'Food',
               'Others' => 'others'
  }

  def self.pin_by_category(tag)
    if tag.downcase == 'others' || tag == ''
      self.where("lower(tag) = '#{tag.downcase}' || tag == '' || tag IS NULL").order('created_at DESC')
    else
      self.where("lower(tag) = '#{tag.downcase}'").order('created_at DESC')
    end
  end

  def preview
    if images.present?
      images.first.image.url
    end
  end
end