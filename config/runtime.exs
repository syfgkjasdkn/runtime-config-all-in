import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.

config :c, CWeb.Endpoint,
  render_errors: [view: CWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: C.PubSub,
  live_view: [signing_salt: "Urm6JRcI"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  config :c, C.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :c, CWeb.Endpoint,
    # For production, don't forget to configure the url host
    # to something meaningful, Phoenix uses this information
    # when generating URLs.
    url: [host: "example.com", port: 80],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("PORT") || "4000")
    ],
    secret_key_base: secret_key_base,
    server: true

  # Do not print debug messages in production
  config :logger, level: :info
end

if config_env() == :dev do
  # For development, we disable any cache and enable
  # debugging.
  #
  # The watchers configuration can be used to run external
  # watchers to your application. For example, we use it
  # with webpack to recompile .js and .css sources.
  config :c, CWeb.Endpoint,
    http: [port: 4000],
    debug_errors: true,
    check_origin: false,
    secret_key_base: "G3Ln+/DGlLRcc0cFikD44j8AS16t7ab5g0CjqhGBkOz2ol5GjHemYelcDWDEjkw5",
    url: [host: "localhost"],
    watchers: [
      node: [
        "node_modules/webpack/bin/webpack.js",
        "--mode",
        "development",
        "--watch-stdin",
        cd: Path.expand("../assets", __DIR__)
      ]
    ],
    # Watch static and templates for browser reloading.
    live_reload: [
      patterns: [
        ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
        ~r"priv/gettext/.*(po)$",
        ~r"lib/c_web/(live|views)/.*(ex)$",
        ~r"lib/c_web/templates/.*(eex)$"
      ]
    ]

  # Configure your database
  config :c, C.Repo,
    username: "postgres",
    password: "postgres",
    database: "c_dev",
    hostname: "localhost",
    show_sensitive_data_on_connection_error: true,
    pool_size: 10

  # Do not include metadata nor timestamps in development logs
  config :logger, :console, format: "[$level] $message\n"
end

if config_env() == :test do
  # Configure your database
  #
  # The MIX_TEST_PARTITION environment variable can be used
  # to provide built-in test partitioning in CI environment.
  # Run `mix help test` for more information.
  config :c, C.Repo,
    username: "postgres",
    password: "postgres",
    database: "c_test#{System.get_env("MIX_TEST_PARTITION")}",
    hostname: "localhost",
    pool: Ecto.Adapters.SQL.Sandbox

  # We don't run a server during test. If one is required,
  # you can enable the server option below.
  config :c, CWeb.Endpoint,
    secret_key_base: "G3Ln+/DGlLRcc0cFikD44j8AS16t7ab5g0CjqhGBkOz2ol5GjHemYelcDWDEjkw5",
    url: [host: "localhost"],
    http: [port: 4002],
    server: false

  # Print only warnings and errors during test
  config :logger, level: :warn
end
