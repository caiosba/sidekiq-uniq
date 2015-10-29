module Sidekiq
  module Uniq
    class Status
      KEY = 'sidekiq_uniq_job'
      
      def self.expiration
        @expiration ||= 60 * 30
      end

      def self.expiration=(seconds)
        @expiration = seconds
      end

      def self.key(msg)
        KEY + ':' + Digest::MD5.hexdigest(msg['class'].to_s + ':' + msg['args'].inspect)
      end

      def self.save_status(msg, status, redis = nil)
        Status.redis(redis) do |conn|
          key = Status.key(msg)
          conn.multi do
            conn.set key, status.to_s
            conn.expire key, Status.expiration
          end
        end
      end

      def self.running_or_enqueued(msg, redis = nil)
        status = ''
        Status.redis(redis) do |conn|
          status = conn.get(Status.key(msg)).to_s
        end
        (status === 'running' || status === 'enqueued')
      end

      def self.clear(redis = nil)
        Status.redis(redis) do |conn|
          keys = conn.keys "#{KEY}*"
          keys.each{ |key| conn.del(key) }
        end
      end

      def self.redis(redis = nil)
        if redis
          redis.with do |conn|
            yield conn
          end
        else
          Sidekiq.redis do |conn|
            yield conn
          end
        end
      end

    end
  end
end
