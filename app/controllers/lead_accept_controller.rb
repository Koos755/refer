class LeadAcceptController < ApplicationController

  before_action :set_lead
  before_action :only_agent


  def agent
    if @lead.accepted_by_agent
      flash[:notice] = "This referral has already been accepted. Please sign in and view under My Referrals."
      redirect_to agent_step4_url({lead_id: @lead.id})
    end
  end

  def agent_reply
    if params[:accept] =='yes'
      @lead.accepted_by_agent_time = Time.now
      @lead.accepted_by_agent = true
      if @lead.save
        redirect_to agent_step2_url({lead_id: @lead.id})
      end
    elsif params[:accept] =='no'
      @lead.accepted_by_agent = false
      @lead.accepted_by_agent_time = Time.now
      WizardMail.receiving_agent_decline(@lead).deliver
      if @lead.save
        render 'agent_decline'
      end
    end
  end

  def agent_step2
    @user = User.new
    @url = agent_step3_url({lead_id: @lead.id})
  end

  def agent_step3
    @user = User.find_by(email: params[:email])
    receiving_agent = current_user
    receiving_agent.name = params[:receiving_agent_name]
    receiving_agent.save
    if @user.present?
      unless @user.broker.present?
        @user.create_with_broker(params[:brokerage_name], @lead)
      end
    else
      @user = User.new(step3_params)
      @user.create_password
      @user.create_with_broker(params[:brokerage_name], @lead)
    end
    @token = Token.new
    @token.create_lead_broker_token(@lead, @user)
    redirect_to agent_step4_url({lead_id: @lead.id})
  end

  def agent_step4
    render 'success_agent'
  end

  private

    def set_lead
      @lead = Lead.find_by(id: params[:lead_id])
    end

    def only_agent
      unless current_user.present? && current_user == @lead.receiving_agent.user
        flash[:error] = "You are not allowed to access that page!"
        redirect_to root_url
      end
    end

    def step3_params
      params.permit(:name,:email)
    end
end
