class BallotsController < ApplicationController
  def index
    ballots = Ballot.where(event_id: params[:event_id])
    render json: ballots
  end

  def create
  end

  def submit
  end

  def show
  end
end
