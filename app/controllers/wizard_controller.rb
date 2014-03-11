class WizzardController < ApplicationController
  def step1
    @user = User.new
    if current_user.present?
      render 'step2'
    end
  end

  def step2
    @user = User.new(step1_params)
    @user.password_confirmation = params[:user][:password]
    if @user.save
      session[:user_id] = @user.id
    else
      render 'step1'
    end

  end

  def step3
  end

  def step4
  end

  private

  def step1_params
    params.require(:user).permit(:name,:email,:password)
  end
end
