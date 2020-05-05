class InvitationsController < ApplicationController
  before_action :fetch_invite, only: [:show, :update, :destroy]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      flash[:success] = "Your invitation has been sent."
      redirect_to event_path(@invitation.invited_to_event)
    else
      render 'new'
    end
  end

  def show
    @event = @invitation.invited_to_event
  end

  def update
    if rsvp_params == 'true'
      @invitation.accept
      flash[:info] = "Invitation accepted! This event has been added to your 'Upcoming Events' list."
    else
      @invitiation.decline
      flash[:info] = "You have declined to attend this event. #{view_context.link_to("Go Back", @invitation)}".html_safe
      redirect_to invitation_path(@invitation)
    end
  end

  def destroy
    @invitation.destroy
    flash[:info] = "Invitation successfully deleted."
    redirect_to root_url
  end

  private

  def invitation_params
    params.require(:invitation).permit(:event_attendee_id, :invited_to_event_id)
  end

  def rsvp_params
    params.require(:response) 
  end

  def fetch_invite
    @invitation = Invitation.find_by(id: params[:id])
  end

end