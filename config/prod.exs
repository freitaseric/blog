import Config

# Endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: System.get_env("URL_HOST", "localhost"), port: 80],
  http: [
    port: String.to_integer(System.get_env("PORT", "4000")),
    transport_options: [socket_opts: [:inet6]]
  ],
  server: true

# Logging
config :logger, level: :info

# Disable Swoosh email
config :swoosh, :api_client, false
