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
    name = params[:name]
    @configuration = ::Configuration.joins(:environment)
      .select(:content)
      .find_by({ environments: { name: name } })
  end
end
