class ReportFake < ActiveRecord::Base
  attr_accessible :activity_id, :is_shame, :user_id
  validates_presence_of :user_id,:activity_id
end
