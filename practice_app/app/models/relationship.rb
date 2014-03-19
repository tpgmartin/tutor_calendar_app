class Relationship < ActiveRecord::Base
  include PublicActivity::Common
  
  attr_accessible :relation_id, :user_id

  belongs_to :user
  belongs_to :relation, :class_name => 'User'
end
