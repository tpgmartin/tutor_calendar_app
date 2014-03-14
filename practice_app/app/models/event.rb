class Event < ActiveRecord::Base
  attr_accessible :created_at, :date, :description, :end_time, :name, :start_time, :updated_at
end
