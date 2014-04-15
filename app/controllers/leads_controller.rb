class LeadsController < ApplicationController

  before_action :set_lead, only: [:show]
  before_action :only_agents_and_broker_can_view_lead, only: [:show]

  def show
  end

  def index
    if current_user.present?
      if current_user.broker.present?
        #TODO add association from broker to leads and then add variables here
      else
        @leads_send = current_user.agent.leads_send
        @leads_received = current_user.agent.leads_received
      end
    else
      flash[:error] = "You have to be logged in to view that page"
      redirect_to root_url
    end
  end

  private

  def set_lead
    @lead = Lead.find_by(id: params[:id])
  end

  def only_agents_and_broker_can_view_lead
    unless [@lead.sending_agent.user, @lead.receiving_agent.user, @lead.broker.user].include?(current_user)
      flash[:error] = "You are not allowed to view this page!"
      redirect_to root_url
    end
  end
end
