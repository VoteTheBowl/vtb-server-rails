class InfoController < ApplicationController
  def version
    render json: { version: "RubyOnRails" }
  end
end
