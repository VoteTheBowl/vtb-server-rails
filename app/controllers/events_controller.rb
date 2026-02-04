class EventsController < ApplicationController
  before_action :set_event
  before_action :check_token
  skip_before_action :set_event, only: %i[ create ]
  skip_before_action :check_token, only: %i[ create ]

  def create
    event_params = params.expect(event: [ :name, :electoral_system, choices: [] ])
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def show
    ballots = Ballot.where(event_id: params[:id])
    unless @event.host_token == @token || @event.share_token == @token || ballots.any? { |ballot| ballot.token == @token }
      render json: error_message("Unauthorized"), status: :unauthorized
    else
      render json: @event, status: :ok
    end
  end

  def close
    unless @event.host_token == @token
      render json: error_message("Unauthorized"), status: :unauthorized
    else
      @event.closed = Time.current
      if @event.save
        render json: {}, status: :ok
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

  def open
    unless @event.host_token == @token
      render json: error_message("Unauthorized"), status: :unauthorized
    else
      @event.closed = nil
      if @event.save
        render json: {}, status: :ok
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

  def show_results
    unless @event.host_token == @token
      render json: error_message("Unauthorized"), status: :unauthorized
    else
      @event.show_results = true
      if @event.save
        render json: {}, status: :ok
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

  def hide_results
    unless @event.host_token == @token
      render json: error_message("Unauthorized"), status: :unauthorized
    else
      @event.show_results = false
      if @event.save
        render json: {}, status: :ok
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def check_token
      @token = request.headers["X-API-Key"]
      unless @token.is_a? String
        render json: error_message("Unauthorized"), status: :unauthorized
      end
    end
end
