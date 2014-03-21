class EventsController < ApplicationController
  load_and_authorize_resource
  before_filter :authorize, only: [:edit, :update]

  def index
    @event = Event.all
    @events_by_date = @event.group_by(&:date) # Want to change &:date 
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def show
    @event = Event.find(params[:id])
    @commentable = @event
    @comments = @commentable.comments
    @comment = Comment.new  
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.users << current_user
    if @event.save
      @event.create_activity :create, owner: current_user
      redirect_to @event, notice: "Event created."
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.users << current_user
    if @event.update_attributes(params[:event])
      @event.create_activity :update, owner: current_user
      redirect_to @event, notice: 'Event updated.'
    else
      render action: "edit" 
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    @event.create_activity :destroy, owner: current_user
    redirect_to events_url 
  end
end
