class Category < ActiveRecord::Base
  has_many :activities
  attr_accessible :name
end
