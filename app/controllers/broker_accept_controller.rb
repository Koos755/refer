class BrokerAcceptController < ApplicationController

  before_action :set_lead
  before_action :only_broker

  def broker
  end

  def broker_reply
    @lead.accepted_by_broker_time = Time.now
    if params[:accept] =='yes'
      @lead.accepted_by_broker = true
      if @lead.save
        WizardMail.lead_accepted(@lead).deliver
        redirect_to broker_step2_url({lead_id: @lead.id})
      end
    elsif params[:accept] =='no'
      @lead.accepted_by_broker = false
      if @lead.save
        render 'broker_decline'
      end
    end
  end

  def broker_step2
    @brokerage = @lead.brokerage
    @broker = @lead.broker
    @destination_url = broker_step3_url({lead_id: @lead.id})
  end


  def broker_step3
    broker_user = @lead.broker.user
    broker_user.name = params[:broker_name]
    broker_user.save
    @brokerage = @lead.brokerage
    if @brokerage.update(step3_params)
      redirect_to broker_step4_url({lead_id: @lead.id})
    else
      @broker = @lead.broker
      render 'broker_step2'
    end
  end

  def broker_step4
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

  def step3_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
