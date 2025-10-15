FROM elixir:1.18.4-slim

ENV MIX_ENV=prod

WORKDIR /app

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  nodejs \
  npm \
  && rm -rf /var/lib/apt/lists/*

COPY mix.exs mix.lock ./
COPY config config

RUN mix local.hex --force && \
  mix local.rebar --force

COPY . .

ENV SECRET_KEY_BASE=RqECyPC8LVJO+Wby+P/yIaj5gYKQRGFrdPnXhzIKlekE8rRUxnX4UQ766nm84OHI

RUN mix deps.get --only prod
RUN mix compile
RUN mix assets.deploy

ENV DATABASE_URL=ecto://postgres:postgres@localhost/blog_prod

RUN mix ecto.migrate

EXPOSE 4000

CMD ["mix", "phx.server"]