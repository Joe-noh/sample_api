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
  secret_key_base: "oVx7EZMb5CfDHWZp2vC/e4urhR+o6zAdNf1kthdjhHZL9DzCFJi9943MOvCbHeMg",
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
