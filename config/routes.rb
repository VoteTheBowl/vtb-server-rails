Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API Info
  get "/api/version", to: "info#version"

  # Events
  post "/api/vote/event/create", to: "events#create"
  get "/api/vote/event/:id", to: "events#show"
  post "/api/vote/event/:id/close", to: "events#close"
  post "/api/vote/event/:id/open", to: "events#open"
  post "/api/vote/event/:id/show-results", to: "events#show_results"
  post "/api/vote/event/:id/hide-results", to: "events#hide_results"

  # Ballot
  get "/api/vote/event/:event_id/ballots", to: "ballots#index"
  post "/api/vote/event/:event_id/create", to: "ballots#create"
  post "/api/vote/ballot/:ballot_id/submit", to: "ballots#submit"
  get "/api/vote/ballot/:id", to: "ballots#show"
end
