class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if  user.present?
      flash[:notice] = "Successfully signed in!"
      session[:user_id] = user.id
      if request.referrer.split('/').last == 'step1'
        redirect_to step2_url
      else
        redirect_to about_index_url
      end

    else
      flash[:error] = "Something went wrong, please try again."
      render 'new'
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully signed out"
    redirect_to root_url
  end
end
