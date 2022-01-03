class API::V1::ConfigurationsController < API::APIController
  before_action :authenticate_with_token!
  before_action :set_configuration, only: [:show]

  def show
    if @configuration
      render json: JSON.parse(@configuration.content)
    else
      render_errors("Configuration does not exist")
    end
  end

  private 

  def set_configuration
    @configuration = Environment.find_by(name: params[:name])&.configuration
  end
end
