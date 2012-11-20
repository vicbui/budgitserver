class Cat < ActiveRecord::Base
  attr_accessible :name, :user_id, :shared_id, :created_at, :updated_at
  belongs_to :user
end
