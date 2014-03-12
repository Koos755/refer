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
      @wizard.save(current_user)
      redirect_to step3_url({lead_id: @wizard.lead_id})
    else
      render 'step2'
    end
  end

  def step3
    @user = User.new
    @lead = Lead.find_by(id: params[:lead])
  end

  def step3_create
    @user = User.find_by(email: params[:user][:email])
    lead = Lead.find_by(id: params[:user][:lead_id])
    if @user.present?
      unless @user.agent.present?
        @user.create_with_agent
        @user.save
      end
    else
      @user = User.new(step3_params)
      @user.create_password
      @user.save
      @user.create_with_agent
      @user.save
    end
    lead.receiving_agent_id = @user.id
    lead.save
    redirect_to step4_url({lead_id: lead.id})
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

  def step3_params
    params.require(:user).permit(:name,:email)
  end
end
