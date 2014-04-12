class LeadAcceptController < ApplicationController

  before_action :set_lead
  before_action :only_agent, only: [:agent, :agent_reply, :agent_step2, :agent_step3]
  before_action :only_broker, only: [:broker, :broker_reply]

  def agent
  end

  def broker
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
      if @lead.save
        #TODO add decline path
      end
    end
  end

  def agent_step2
    @user = User.new
    @url = agent_step3_url({lead_id: @lead.id})
  end

  def agent_step3
    @user = User.find_by(email: params[:user][:email])
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
    render 'success_agent'
  end

  def broker_reply
    if params[:accept] =='yes'
      @lead.accepted_by_broker_time = Time.now
      @lead.accepted_by_broker = true
      if @lead.save
        WizardMail.lead_accepted(@lead).deliver
        render 'success_broker'
      end
    elsif params[:accept] =='no'
      @lead.accepted_by_agent = false
      if @lead.save
        #TODO add decline path
      end
    end
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

    def only_broker
      unless current_user.present? && current_user == @lead.receiving_agent.broker.user
        flash[:error] = "You are not allowed to access that page!"
        redirect_to root_url
      end
    end

    def step3_params
      params.require(:user).permit(:name,:email)
    end
end
