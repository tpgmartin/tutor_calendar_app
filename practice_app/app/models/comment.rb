class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :commenter_id, :commenter_type :content

  belongs_to :commenter, polymorphic: true
  belongs_to :commentable, polymorphic: true
end
