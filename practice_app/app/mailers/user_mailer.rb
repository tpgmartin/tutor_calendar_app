class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Sign Up Confirmation"
  end

  def invite_email(invitation, signup_url)
    @user = invitation
    @sign_url  = signup_url
    mail to: invitation.recipient_email, subject: "Invitation"
  end

  # def invitation(invitation, signup_url)
  #   subject    'Invitation'
  #   recipients invitation.recipient_email
  #   from       'foo@example.com'
  #   body       :invitation => invitation, :signup_url => signup_url
  #   invitation.update_attribute(:sent_at, Time.now)
  # end
end
