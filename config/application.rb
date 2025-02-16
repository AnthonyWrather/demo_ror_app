require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DemoRorApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Good Job for Active Job - config/application.rb or config/environments/{RAILS_ENV}.rb
    config.active_job.queue_adapter = :good_job

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # config/environments/application.rb or a specific environment e.g. production.rb

    # Enable cron enqueuing in this process
    config.good_job.enable_cron = true

    # Without zero-downtime deploys, re-attempt previous schedules after a deploy
    config.good_job.cron_graceful_restart_period = 1.minute

    # good_job - Configure cron with a hash that has a unique key for each recurring job
    config.good_job.cron = {
      frequent_task: { # each recurring job must have a unique key
      # cron: "*/5 * * * *", # cron-style scheduling format by fugit gem
      # cron: "5 21 * * *", # cron-style scheduling format by fugit gem
      cron: "@midnight",
      class: "UrgentTaskJob", # name of the job class as a String; must reference an Active Job job class
        description: "Send notifications for Urgent Tasks." # optional description that appears in Dashboard
      }
      # production_task: {
      #   cron: "0 0,12 * * *",
      #   class: "ProductionJob",
      #   enabled_by_default: -> { Rails.env.production? } # Only enable in production, otherwise can be enabled manually through Dashboard
      # },
      # complex_schedule: {
      #   class: "ComplexScheduleJob",
      #   cron: -> (last_ran) { (last_ran.blank? ? Time.now : last_ran + 14.hours).at_beginning_of_minute }
      # }
      # etc.
    }
  end
end
