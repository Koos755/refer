class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if  user.present? && user.authenticate(params[:password])
      # flash[:notice] = "Successfully signed in!"
      session[:user_id] = user.id
      # redirect_to parent_url(parent)
      if request.referrer.split('/').last == 'step1'
        redirect_to step2_url
      end
    else
      flash[:error] = "Something went wrong, please try again."
      render 'new'
    end
  end

  def destroy
  end
end
