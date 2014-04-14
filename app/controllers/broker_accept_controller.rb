class BrokerAcceptController < ApplicationController

  before_action :set_lead
  before_action :only_broker

  def broker
  end

  def broker_reply
    if params[:accept] =='yes'
      @lead.accepted_by_broker_time = Time.now
      @lead.accepted_by_broker = true
      if @lead.save
        WizardMail.lead_accepted(@lead).deliver
        redirect_to broker_step3_url({lead_id: @lead.id})
      end
    elsif params[:accept] =='no'
      @lead.accepted_by_agent = false
      if @lead.save
        #TODO add decline path
      end
    end
  end

  def broker_step2
    @brokarage = @lead.broker
    @broker = @lead.broker
  end


  def broker_step3
    render 'success_broker'
  end

  private

  def set_lead
    @lead = Lead.find_by(id: params[:lead_id])
  end

  def only_broker
    unless current_user.present? && current_user == @lead.receiving_agent.broker.user
      flash[:error] = "You are not allowed to access that page!"
      redirect_to root_url
    end
  end
end
