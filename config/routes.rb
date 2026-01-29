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
  patch "/api/vote/event/:id/update", to: "events#update"
end
