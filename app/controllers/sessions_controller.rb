class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:provider]
      render plain: env["omniauth.auth"].to_yaml
    else
      user = User.where(:name => params[:signin][:name]).first


      if user and user.authenticate(params[:signin][:password])
        session[:user_id] = user.id
        flash[:notice] = "Signed in successfully."

        redirect_to root_url
      else
        flash[:error] = "Sorry."
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil

    flash[:notice] = "Signed out successfully"

    redirect_to root_url
  end
  
end
