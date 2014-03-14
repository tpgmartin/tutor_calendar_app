class EventsController < ApplicationController

  def index
    @event = Event.all
    @events_by_date = @event.group_by(&:date) # Want to change &:date 
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
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
    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event updated.'
    else
      render action: "edit" 
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url 
  end
end
