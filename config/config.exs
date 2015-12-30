# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the namespace used by Phoenix generators
config :sample_api,
  app_namespace: SampleAPI

# Configures the endpoint
config :sample_api, SampleAPI.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "cAe+MZgMKf0ZJuXjEgYN4jSX89PH8sENqTtz+p4Hm4u5eAsmvW1Pva9k2eQy3QVP",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: SampleAPI.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
