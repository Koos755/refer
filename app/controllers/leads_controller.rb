class LeadsController < ApplicationController

  before_action :only_current_users
  before_action :set_lead, only: [:show]
  before_action :only_agents_and_broker_can_view_lead, only: [:show]

  def show
  end

  def index
    if current_user.broker.present?
      @leads_send = current_user.broker.leads_send
      @leads_received = current_user.broker.leads_received
    elsif current_user.agent.present?
      @leads_send = current_user.agent.leads_send
      @leads_received = current_user.agent.leads_received
    else
      @leads_send = []
      @leads_received =[]
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

  def only_current_users
    unless current_user.present?
      flash[:error] = "You have to be logged in to view that page"
      redirect_to root_url
    end
  end
end
