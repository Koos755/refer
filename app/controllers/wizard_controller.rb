class WizardController < ApplicationController

  before_action :set_lead, only: [:step3, :step3_create, :step4, :step4_create, :step5]

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
      WizardMail.send_signup_email(@user).deliver
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
  end

  def step3_create
    @user = User.find_by(email: params[:user][:email])
    if @user.present?
      unless @user.agent.present?
        @user.create_with_agent
      end
    else
      @user = User.new(step3_params)
      @user.create_password
      @user.create_with_agent
    end
    @lead.receiving_agent_id = @user.agent.id
    @lead.save
    redirect_to step4_url({lead_id: @lead.id})
  end

  def step4
  end

  def step4_create
    if params[:accepted_terms] == "true"
      @lead.accepted_terms = Time.now
      @lead.save
      token = Token.new
      token.create_lead_agent_token(@lead)
      WizardMail.send_lead_receiving_agent(@lead, token).deliver
      redirect_to step5_url({lead_id: @lead.id})
    else
      render 'step4'
    end
  end

  def step5
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

  def set_lead
    @lead = Lead.find_by(id: params[:lead_id])
  end
end
