class FriendshipsController < ApplicationController
 
  def accept_friendship
    if Friendship.accept(current_user, User.get(params[:user_id])) # means that current user just acknowledged friend's request
      @notice = "#{friend.first_name} was confirmed as your friend on Gowalla"
    else
      @notice = "There was a problem accepting this friend request"
    end
    respond_to do |format|
      format.html { redirect_to( user_path(current_user), :notice => @notice) }
      format.json { render :json => {} }
    end
  end
  
  def reject_friendship
    Friendship.reject(current_user, User.get(params[:user_id]))
    render :json => {}
  end


end