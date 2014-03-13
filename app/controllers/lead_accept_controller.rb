class LeadAcceptController < ApplicationController

  before_action :set_lead
  before_action :only_agent, only: [:agent, :agent_reply]
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
    @url = agent_step3_url
  end

  def broker_apply
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
end
