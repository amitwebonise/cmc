class Activity < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category
  has_one :location
  has_many :shames
  has_many :comments
  serialize :media, Array
  accepts_nested_attributes_for :location


  attr_accessible :activity_for, :contact_person, :description, :is_anonymous, :media, :user_id, :category_id, :image, :location, :subject#, :location_attributes
  validates_presence_of :subject, :category_id, :description, :media#, :contact_person

  #def image_data=(data)
  #  # decode data and create stream on them
  # # io = ::CarrierStringIO.new(Base64.decode64(data))
  #
  #  # this will do the thing (photo is mounted carrierwave uploader)
  #  self.image = io
  #end

  def shame_count
    shames.count
  end
  def comment_count
    comments.count
  end
end
