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
    @wizard = Wizard.new
  end

  def step2_create
    @wizard = Wizard.new(step2_params)
    if @wizard.valid?
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

  def step2_params
    params.require(:wizard).permit(:name, :email, :mobile, :buying, :selling, :price_range_start, :price_range_end)
  end
end
