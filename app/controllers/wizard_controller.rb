class WizardController < ApplicationController
  def step1
    @user = User.new
    if current_user.present?
      redirect_to step2_url
    end
  end

  def step1_create
    @user = User.new(step1_params)
    @user.password_confirmation = params[:user][:password]
    if @user.save
      @user.create_with_agent
      session[:user_id] = @user.id
      redirect_to step2_url
    else
      render 'step1'
    end
  end

  def step2_create
    @user
    @buying = params[:buying]
    render 'step3'
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
