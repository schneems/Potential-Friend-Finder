class UsersController < ApplicationController
  
  def show
    @user = User.where(:id => params[:id]).first
    puts 
    @users = current_admin.users.where("id not in (#{@user.not_potential_friend_ids.join(",")})")
  end
  
  
  def new  
    @user = User.new  
  end  

  def create  
    params[:user][:avatar] = StringIO.new(HTTParty.get(params[:url_for_avatar]).body) unless params[:url_for_avatar].blank?
    params[:user][:admin_id] = current_admin.id unless current_admin.blank?
    @user = User.new(params[:user])  
    if @user.save  
      notice = "Registration successful."  
    end
    redirect_to :back, :notice => notice
  end

  def index
    @users = User.all
  end
  
  def edit  
    @user = User.where(:id => params[:id]).first
  end  

  def update  
    @user = User.where(:id => params[:id]).first
    if @user.update_attributes(params[:user])  
      flash[:notice] = "Successfully updated profile."  
      redirect_to root_url  
    else  
      render :action => 'edit'  
    end  
  end
  
  
end
