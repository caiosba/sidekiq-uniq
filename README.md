# Sidekiq Uniq

This is an extension for Sidekiq that by default doesn't allow a job to be enqueued if it's already in the queue or being processed.

It does so by keeping in Redis the information about each job's status, where a job is identified by its class and arguments. Possible statuses are: enqueued, running and completed. In case a job fails and is unable to release the lock, all status keys expire (by using Redis' `EXPIRE` command) after some time (which can be defined by `Sidekiq::Uniq::Status.expiration = <time in seconds>`).

Useful to use with recurring jobs, like the ones created by [sidekiq-cron](https://github.com/ondrejbartas/sidekiq-cron).

When such thing is not used, if you have tons of jobs to be processed, and the time to process the queue is greater than the interval of
the jobs, you can end up with a huge queue on Redis, leading to memory usage problems (protip).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-uniq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-uniq

## Usage

If you want the default behavior (which is to not allow a job to be enqueued if it's already in the queue), nothing is needed.

If you want to avoid the default behavior for a given job, just add `sidekiq_options unique: false` to it.

Expiration time can be defined like this: `Sidekiq::Uniq::Status.expiration = <time in seconds>`. The default value is 30 minutes.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
