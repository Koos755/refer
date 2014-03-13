class LeadAcceptController < ApplicationController

  before_action :set_lead
  before_action :only_agent, only: [:agent, :agent_reply]
  before_action :only_broker, only: [:broker, :broker_reply]

  def agent
  end

  def broker
  end

  def agent_reply

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
