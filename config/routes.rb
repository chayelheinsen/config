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

    root to: "environments#index"
  end

  namespace :api do

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "hello", to: "hello#index"
end
