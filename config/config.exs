# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :cookBook, CookBook.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "cookBook_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"


# General application configuration
config :cookBook,
  ecto_repos: [CookBook.Repo]

# Configures the endpoint
config :cookBook, CookBook.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0wbPShfOd30Ili21mKNnlNqCHmW3wOcZA9/G6HIGbey8+Rm/TOQIV/ebjzds6MIW",
  render_errors: [view: CookBook.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CookBook.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
