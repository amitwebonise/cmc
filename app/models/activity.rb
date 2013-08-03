class Activity < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_one :location

 # accepts_nested_attributes_for :location_attributes
  attr_accessible :activity_for, :contact_person, :description, :is_anonymous, :media, :user_id, :category_id, :image#, :location_attributes

end
