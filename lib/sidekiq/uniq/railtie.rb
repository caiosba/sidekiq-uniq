require 'sidekiq/uniq/middleware'

module Sidekiq
  module Uniq
    class Railtie < ::Rails::Railtie
      initializer 'sidekiq_uniq_middleware' do

        Sidekiq.configure_server do |config|
          config.client_middleware do |chain|
            chain.add Sidekiq::Uniq::Middleware
          end
        end

        Sidekiq.configure_client do |config|
          config.client_middleware do |chain|
            chain.add Sidekiq::Uniq::Middleware
          end
        end

      end
    end
  end
end
