
class RelationshipsController < ApplicationController
  before_filter :signed_in_user
  respond_to :html, :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    send_new_follower_notification(@user, current_user) if @user.notify
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end

  def send_new_follower_notification(current_user)
    UserMailer.new_follower_notification(followed_user, follower).deliver
  end
end
