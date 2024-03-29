class TokenController < ApplicationController

  def value
    token = Token.find_by(value: params[:value])
    if token.present?
      token.count += 1
      token.save
      if token.token_type == 'lead_agent'
        if token.lead.accepted_by_agent
          flash[:notice] = "This referral has already been accepted. Please sign in and view under My Referrals."
          redirect_to root_url
        else
          session[:user_id] = token.user_id
          redirect_to agent_step1_url({lead_id: token.lead.id})
        end
      elsif token.token_type == 'lead_broker'
        if token.lead.accepted_by_broker
          flash[:notice] = "This referral has already been accepted. Please sign in and view under My Referrals."
          redirect_to root_url
        else
          session[:user_id] = token.user_id
          redirect_to broker_step1_url({lead_id: token.lead.id})
        end
      elsif token.token_type == 'password_reset'
        if Time.now - token.created_at > 7200
          flash.now[:error] = "Token have expired. Please request a new one"
          render 'value'
        else
          session[:user_id] = token.user.id
          render 'sessions/set_password'
        end
      end
    else
      flash[:notice] = "Unknown Token...."
      redirect_to root_url
    end
  end

end
