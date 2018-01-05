# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :genocide,
  ecto_repos: [Genocide.Repo]

# Configures the endpoint
config :genocide, Genocide.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NjeRMcIrEya172SADjii4BxaTHo4ol0hSw8B4IXJS6A/EUUJdfS5ngwU0GXmbPqS",
  render_errors: [view: Genocide.ErrorView, accepts: ~w(json)],
  pubsub: [name: Genocide.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
