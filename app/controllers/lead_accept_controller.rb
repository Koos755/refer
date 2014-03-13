class LeadAcceptController < ApplicationController

  def agent
    @lead = Lead.find_by(id: params[:lead_id])
    if current_user.present? && current_user == @lead.receiving_agent.user
      render 'agent'
    else
      flash[:error] = "You are not allowed to access that page!"
      redirect_to root_url
    end
  end

  def broker
    @lead = Lead.find_by(id: params[:lead_id])
    if current_user.present? && current_user == @lead.receiving_agent.broker.user
      render 'broker'
    else
      flash[:error] = "You are not allowed to access that page!"
      redirect_to root_url
    end
  end

  def agent_reply
  end

  def broker_apply
  end
end
