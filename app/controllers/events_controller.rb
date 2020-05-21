class EventsController < ApplicationController
  include EventsHelper
  include SessionsHelper

  def index
    @upcoming_events = Event.upcoming_events
    @past_events = Event.past_events
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "The '#{@event.name}' event has been created successfully!"
      redirect_to @event
    else
      flash[:danger] = 'An error occurred. Please make sure you fill out all fields.'
      render 'new'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    @event_creator = :event_creator
    @past_events = Event.past_events
    @upcoming_events = Event.upcoming_events
    @invite_enable = @event.invite_enable
    @confirmed_attendees = @event.confirmed_attendees
  end

  private

  def event_params
    params.require(:event).permit(:name, :event_date, :description)
  end
end
