class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      UserMailer.invite_email(@invitation, signup_url(@invitation.token)).deliver
      # UserMailer.deliver(@invitation, signup_url(@invitation.token))
      flash[:notice] = "Thank you, invitation sent."
      redirect_to current_user
    else
      render :action => 'new'
    end
  end

end
