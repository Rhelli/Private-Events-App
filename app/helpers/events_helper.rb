module EventsHelper
  def event_creator
    current_user == event.creator
  end
end
