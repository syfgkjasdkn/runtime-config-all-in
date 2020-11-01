# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :c,
  ecto_repos: [C.Repo]

# Configures the endpoint
config :c, CWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G3Ln+/DGlLRcc0cFikD44j8AS16t7ab5g0CjqhGBkOz2ol5GjHemYelcDWDEjkw5",
  render_errors: [view: CWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: C.PubSub,
  live_view: [signing_salt: "Urm6JRcI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
