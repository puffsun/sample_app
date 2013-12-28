
class UserMailer < ActionMailer::Base
  default from: "sunwiner@yeah.net"

  def registration_confirmation(user)
    mail(to: user.email, subject: "Registered")
  end

  def new_follower_notification(user, follower)
    @user = follower
    mail(to: user.email, subject: "New follower")
  end
end
