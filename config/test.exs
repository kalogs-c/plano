import Config

config :plano, token_signing_secret: "vII8JWxASw5ZvN94So4L53OfForGyfvl"
config :bcrypt_elixir, log_rounds: 1

config :ash,
  policies: [show_policy_breakdowns?: true],
  keyset_signing_secret: "D4YT0kv15UvNg+PyOxAwLt1KNg95/U30m8zJJMv5jt4",
  disable_async?: true

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :plano, Plano.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "plano_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :plano, PlanoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "W/6R6Mc4UKs7Awa9HvUmszUMjnPq9+KFVM7BjFlg7gb0Yts9WznQ5Q5+W15PgUey",
  server: false

# In test we don't send emails
config :plano, Plano.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Sort query params output of verified routes for robust url comparisons
config :phoenix,
  sort_verified_routes_query_params: true
