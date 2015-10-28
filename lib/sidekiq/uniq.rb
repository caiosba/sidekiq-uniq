require 'sidekiq/uniq/version'
require 'sidekiq/uniq/railtie'

module Sidekiq
  module Uniq
    def call(worker_class, msg, queue_name, redis_pool)
      unless msg['unique'] === false
        queue = Sidekiq::Queue.new(msg['queue'])
        queue.each do |job|
          return false if job.klass == msg['class'] && job.args === msg['args']
        end
      end
      yield
    end
  end
end
