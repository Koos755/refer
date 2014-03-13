class TokenController < ApplicationController

  def value
    token = Token.find_by(value: params[:value])
    if token.token_type == 'lead_agent'
      session[:user_id] = token.lead.receiving_agent.user.id
      redirect_to agent_accept_url({lead_id: token.lead.id})
    elsif token.token_type == 'lead_broker'
      session[:user_id] = token.lead.receiving_agent.user.id
      redirect_to broker_accept_url({lead_id: token.lead.id})
    elsif token.token_type == 'password_reset'
      if token.created_at > 7200
        render 'value'
      end
      @user = token.user
      render 'new_password'
    end
  end

  def agent
    @lead = Lead.find_by(id: params[:lead_id])
  end

  def broker
    @lead = Lead.find_by(id: params[:lead_id])
  end
end
