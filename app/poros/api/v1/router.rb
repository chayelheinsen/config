class API::V1::Router
  
  attr_reader :rails_router
  
  delegate :get, :post, :delete, to: :rails_router
  # delegate :post, to: :rails_router
  # delegate :delete, to: :rails_router

  def initialize(rails_router)
    @rails_router = rails_router
  end

  # Creates all the routes for this router
  #
  # Use this within the routes.rb file:
  #
  #   Application.routes.draw do |map|
  #     namespace :api do
  #       namespace :v1 do
  #         API::V1::Router.new(self).routes
  #       end
  #     end
  #   end
  #
  # @param rails_router [ActionDispatch::Routing::Mapper]
  def routes
    # Session
    post "users/login" => "sessions#create"
    delete "users/logout" => "sessions#destroy"

    # Configuration
    get "configurations/*name" => "configurations#show"
  end
end