class LeadsController < ApplicationController

  before_action :only_current_users, only: [:index]
  before_action :set_lead, only: [:show, :agreement]
  before_action :only_agents_and_broker_can_view_lead, only: [:show, :agreement]

  def show
  end

  def index
    if current_user.broker.present?
      @leads_sent = current_user.broker.leads_sent
      @leads_received = current_user.broker.leads_received
    elsif current_user.agent.present?
      @leads_sent = current_user.agent.leads_sent
      @leads_received = current_user.agent.leads_received
    else
      @leads_sent = []
      @leads_received =[]
    end
  end

  def agreement
    unless @lead.accepted?
      flash.now[:error] = "You can only view agreement once it has been accepted by all parties"
      redirect_to leads_url
    end

    render :layout => false
  end

  private

  def set_lead
    @lead = Lead.find_by(id: params[:id])
  end

  def only_agents_and_broker_can_view_lead
    unless [@lead.sending_agent.try(:user), @lead.receiving_agent.try(:user), @lead.broker.try(:user)].include?(current_user)
      flash[:error] = "Sorry, you have to be signed in and have permission to view this page."
      redirect_to root_url
    end
  end

  def only_current_users
    unless current_user.present?
      flash[:error] = "Sorry, you have to be signed in to view this page."
      redirect_to root_url
    end
  end
end
