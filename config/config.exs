# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_view_demo,
  ecto_repos: [LiveViewDemo.Repo]

# Configures the endpoint
config :live_view_demo, LiveViewDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6DjSqluw9AIo0SKo3gPnSkPK81+GDi31OYlKcnSpbNJ3eP21CElVgqzOvjL7G5Fy",
  render_errors: [view: LiveViewDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveViewDemo.PubSub,
  live_view: [signing_salt: "+9x4LLqM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
