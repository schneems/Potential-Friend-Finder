class AdminsController < ApplicationController

  def create_users
    @user = User.new
    @users = User.all
  end



  def edit
    @admin = current_admin
  end


  def index
    if current_admin.blank?
      redirect_to new_admin_path, :notice => "Please Log In" and return true
    end
  end

  def show

    if current_admin.blank?
      redirect_to new_admin_path, :notice => "Please Log In" and return true
    end
    @admin = current_admin
    @user = @admin.users.new
    @users = User.where(:admin_id => @admin.id)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      notice = "Registration successful."
    end
    redirect_to admin_path(@admin), :notice => notice
  end


  def seed
    return false if current_admin.blank? || (taxonomy = params[:taxonomy].downcase.to_s).blank?
    Dir[Rails.root.join("public/images/#{taxonomy}/*.jpeg")].each do |file|
      image = open(file)
      username = file.match(/([^\/]*)\.jpeg$/) && ($1).to_s
      current_admin.users.create(:username => username, :avatar => image)
    end
    redirect_to admin_path(current_admin)
  end

end
