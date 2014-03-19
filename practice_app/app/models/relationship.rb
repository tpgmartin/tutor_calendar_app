class Relationship < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  
  attr_accessible :relation_id, :user_id

  belongs_to :user
  belongs_to :relation, :class_name => 'User'
end
