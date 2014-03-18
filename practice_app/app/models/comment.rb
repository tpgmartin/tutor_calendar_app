class Comment < ActiveRecord::Base
  attr_accessible :content

  belongs_to :commenter, polymorphic: true
  belongs_to :commentable, polymorphic: true
end
