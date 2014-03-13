class TokenController < ApplicationController
  def value
    token = Token.find_by(value: params[:value])
    if token.token_type == 'lead_agent'
      redirect_to agent_accept_url
    elsif token.token_type == 'lead_broker'
      redirect_to broker_accept_url
    elsif token.token_type == 'password_reset'
    end
  end

  def agent

  end

  def broker

  end
end
