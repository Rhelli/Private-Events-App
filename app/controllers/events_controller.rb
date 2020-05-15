class EventsController < ApplicationController
  def index
    @events = Event.all
    # TODO: Remove 'all events' and segregate page using upcoming and past events
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
  end

  private

  def event_params
    params.require(:event).permit(:name, :event_date, :description)
  end
end
