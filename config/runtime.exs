import Config

if System.get_env("PHX_SERVER") do
  config :blog, BlogWeb.Endpoint, server: true
end

if config_env() == :prod do
  config :blog, Blog.Repo,
    username: System.get_env("DB_USERNAME", "postgres"),
    password: System.get_env("DB_PASSWORD", "postgres"),
    hostname: System.get_env("DB_HOSTNAME", "localhost"),
    database: System.get_env("DB_NAME", "blog_db"),
    pool_size: 10,
    ssl: String.to_atom(System.get_env("DB_SSL", "false"))

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise "environment variable SECRET_KEY_BASE is missing"

  port = String.to_integer(System.get_env("PORT") || "4000")

  config :blog, BlogWeb.Endpoint,
    url: [host: "localhost", port: port],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base
end
