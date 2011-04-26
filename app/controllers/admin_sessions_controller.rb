class AdminSessionsController < ApplicationController
  def new
    @admin_session = AdminSession.new
  end

  def create
    @admin_session = AdminSession.new(params[:user_session])
    if @admin_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def destroy
    @admin_session = AdminSession.find
    @admin_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end


end
