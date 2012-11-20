class Device < ActiveRecord::Base
 
  attr_accessible :name, :serverid, :uuid, :user_id
  belongs_to :user
  validates_uniqueness_of :serverid
 
end
