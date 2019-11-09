# frozen_string_literal: true

Resque.redis = ENV['REDIS_URL']
Resque.schedule = ActiveScheduler::ResqueWrapper.wrap(
  YAML.load_file(
    Rails.root.join('config', 'schedule.yml')
  )
)
