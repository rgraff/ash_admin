use Mix.Config

pg_url = System.get_env("PG_URL") || "postgres:postgres@127.0.0.1"
pg_database = System.get_env("PG_DATABASE") || "ash_admin_dev"
Application.put_env(:ash_admin, Demo.Repo, url: "ecto://#{pg_url}/#{pg_database}")

config :phoenix, :json_library, Jason
config :ash_admin, ecto_repos: [Demo.Repo]

config :ash_admin,
  apis: [
    Demo.Accounts.Api,
    Demo.Tickets.Api
  ]

config :ash_admin, DemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Hu4qQN3iKzTV4fJxhorPQlA/osH9fAMtbtjVS58PFgfw3ja5Z18Q/WSNR9wP4OfW",
  live_view: [signing_salt: "hMegieSe"],
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  check_origin: false,
  pubsub_server: Demo.PubSub,
  server: true,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      System.get_env("NODE_ENV") || "production",
      "--watch-stdin",
      cd: "assets"
    ]
  ],
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/ash_admin/(components|pages)/.*(ex)$"
    ]
  ]

config :logger, level: :debug
config :phoenix, :serve_endpoints, true
