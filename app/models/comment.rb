class Comment < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
  attr_accessible :activity_id, :description, :user_id
  validates_presence_of :user_id,:activity_id, :description

  def name
    user.name
  end
end
