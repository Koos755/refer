class LeadsController < ApplicationController

  def show
  end

  def index
  end

  private

  def set_lead
    @lead = params[:id]
  end
end
