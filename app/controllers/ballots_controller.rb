class BallotsController < ApplicationController
  before_action :has_token
  before_action :get_ballot, only: %i[ show submit ]

  def index
    event = Event.find(params[:event_id])
    ballots = Ballot.where(event_id: params[:event_id])
    unless ballots.any? { |ballot| ballot.token == @token } or event.host_token == @token
      render json: error_message("Unauthorized"), status: :unauthorized
    else
      render json: ballots
    end
  end

  def create
    ballot_params = params.expect(ballot: [ :voter_name ])
    event = Event.find(params[:event_id])

    unless event.share_token == @token or event.host_token == @token
      render json: error_message("Unauthorized"), status: :unauthorized
    else
      ballot = Ballot.new(ballot_params.merge({ "event_id": params[:event_id] }))

      if ballot.save
        render json: { "ballot_id": ballot.id, "ballot_token": ballot.token }, status: :created
      else
        render json: ballot.errors, status: :unprocessable_entity
      end
    end
  end

  def submit
    vote = params.expect(vote: [])
    unless @ballot.token == @token
      render json: error_message("Unauthorized"), status: :unauthoriozed
    else
      @ballot.vote = vote
      @ballot.submitted = Time.current
      if @ballot.save
        render json: {}, status: :ok
      else
        render json: ballot.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    unless @ballot.token == @token
      render json: error_message("Unauthorized"), status: :unauthorized
    else
      render json: @ballot, status: :ok
    end
  end

  private
  def get_ballot
    puts params
    @ballot = Ballot.find(params[:id])
  end
  def has_token
    @token = request.headers["X-API-Key"]
    unless @token.is_a? String
      render json: error_message("Unauthorized"), status: :unauthorized
    end
  end
end
