class Event < ActiveRecord::Base
  include PublicActivity::Common

  has_and_belongs_to_many :users
  attr_accessible :created_at, :date, :description, :end_time, :name, :start_time, :updated_at
  acts_as_readable :on => :created_at
  has_many :comments, as: :commentable
  acts_as_commentable
  validates_presence_of :name, :date, :start_time, :end_time

  # attr_accessor :end_time, :start_time

  # # add some callbacks
  # after_initialize :get_datetimes # convert db format to accessors
  # before_validation :set_datetimes # convert accessors back to db format

  # def get_datetimes
  #   self.date ||= self.date.to_date.to_s(:db) # extract the date is yyyy-mm-dd format
  #   self.start_time ||= "#{'%02d' % self.date.hour}:#{'%02d' % self.date.min}" # extract the time
  #   self.end_time ||= "#{'%02d' % self.date.hour}:#{'%02d' % self.date.min}" # extract the time
  # end

  # def set_datetimes
  #   self.published_at = "#{self.published_at_date} #{self.published_at_time}:00" # convert the two fields back to db
  # end  
end
