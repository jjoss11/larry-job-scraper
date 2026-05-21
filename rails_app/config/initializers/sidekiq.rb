# Configure Sidekiq (example). You'll run Sidekiq to process background jobs.
# Customize connection/queues as needed.
Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] || "redis://localhost:6379/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] || "redis://localhost:6379/0" }
end
