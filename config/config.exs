# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gameoflife,
  ecto_repos: [Gameoflife.Repo]

# Configures the endpoint
config :gameoflife, GameoflifeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NBGl/XLFyFmx0ikM19TS2MMwC37HvHQOpCMs5+VMEdxeHAdB2kuiWzOjLNsPjd+F",
  render_errors: [view: GameoflifeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Gameoflife.PubSub,
  live_view: [signing_salt: "Ke1hZjRP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
