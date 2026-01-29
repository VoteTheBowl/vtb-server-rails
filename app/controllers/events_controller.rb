class EventsController < ApplicationController
  before_action :set_event, only: %i[ show update ]
  before_action :token_present
  skip_before_action :token_present, only: %i[ create ]

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
    render json: @event, status: :ok
  end

  def update
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def token_present
      @token = request.headers["X-API-Key"]
      unless @token.is_a? String
        render json: "No Token provided.", status: :unauthorized
      end
    end
end
