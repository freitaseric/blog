import Config

# Database
config :blog, Blog.Repo,
  username: System.get_env("DB_USERNAME", "postgres"),
  password: System.get_env("DB_PASSWORD", "postgres"),
  hostname: System.get_env("DB_HOSTNAME", "localhost"),
  database: System.get_env("DB_NAME", "blog_prod"),
  ssl: String.to_atom(System.get_env("DB_SSL", "false")),
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "10"))

# Endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: System.get_env("URL_HOST", "localhost"), port: 80],
  http: [
    port: String.to_integer(System.get_env("PORT", "4000")),
    transport_options: [socket_opts: [:inet6]]
  ],
  https: [
    port: 4001,
    cipher_suite: :strong,
    keyfile: "priv/cert/selfsigned_key.pem",
    certfile: "priv/cert/selfsigned.pem"
  ],
  server: true

# Logging
config :logger, level: :info

# Disable Swoosh email
config :swoosh, :api_client, false
