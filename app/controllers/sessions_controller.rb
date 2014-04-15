class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if  user.present? && user.authenticate(params[:password])
      flash[:notice] = "Signed in sucessfully."
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
    flash[:notice] = "Signed out successfully."
    redirect_to root_url
  end

  def reset
  end

  def set_password
    @user = current_user
  end

  def submit_reset
    @user = current_user
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    @user.auto_password = false
    if @user.save
      flash[:notice] = "Password updated."
      redirect_to root_url
    else
      flash[:error] = "Something went wrong, please try again."
      render 'set_password'
    end
  end

end
