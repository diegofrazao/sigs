class ApplicationController < ActionController::Base
  def index
    @service = Service.new
    render :index
  end
end
