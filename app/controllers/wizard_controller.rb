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

  def step2
  end

  def step2_create
    @user = User.new(step2_user_params)
    @user.create_password
    if @user.save
      lead = Lead.new(step2_lead_params)
      lead.user_id = @user.id
      lead.sending_agent_id = current_user.agent.id
      lead.save
      redirect_to step3_url
    else
      render 'step2'
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

  def step2_user_params
    params.permit(:name, :email, :mobile)
  end

  def step2_lead_params
    params.permit(:buying, :selling, :price_range_start, :price_range_end)
  end
end
