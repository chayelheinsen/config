require "sidekiq/web"

Rails.application.routes.draw do
  scope :monitoring do
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_AUTH_PASSWORD"]))
    end if Rails.env.production?

    mount Sidekiq::Web, at: '/sidekiq'
  end

  namespace :admin do
    resources :environments
    resources :configurations
    resources :api_keys

    root to: "environments#index"
  end

  namespace :api do
    namespace :v1 do
      API::V1::Router.new(self).routes 
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
