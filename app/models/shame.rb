class Shame < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
  attr_accessible :activity_id, :is_shame, :user_id
  validates_presence_of :user_id,:activity_id

end
