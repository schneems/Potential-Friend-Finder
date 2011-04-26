class FriendshipsController < ApplicationController
  
  # used only for purposeses of demo, don't actually put this in your code
  def create_arbitrary_friendship
    user_1 = current_admin.users.find(params[:user_1])
    user_2 = current_admin.users.find(params[:user_2])
    Friendship.create_arbitrary_friendship(user_2, user_1 )
    redirect_to :back, :notice => "#{user_1.username} now friends with #{user_2.username}"
  end
  
  # used only for purposeses of demo, don't actually put this in your code
  def destroy_arbitrary_friendship
    user_1 = current_admin.users.find(params[:user_1])
    user_2 = current_admin.users.find(params[:user_2])
    Friendship.destroy_arbitrary_friendship(user_2, user_1 )
    puts "============================================================="
    redirect_to :back, :notice => "#{user_1.username} totally hates #{user_2.username} and vice-versa, DE-FRIENDSHIP COMPLETE"
  end
 
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