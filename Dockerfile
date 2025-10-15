FROM elixir:1.18.4-slim AS base

FROM base AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  nodejs \
  npm \
  && rm -rf /var/lib/apt/lists/*

COPY mix.exs mix.lock ./
COPY config config

RUN export SECRET_KEY_BASE=$(mix phx.gen.secret) 

RUN mix phx.gen.cert blog blog.local blog.freitaseric.com

COPY . .

RUN mix deps.get --only prod
RUN MIX_ENV=prod mix compile
RUN MIX_ENV=prod mix assets.deploy

FROM base AS runtime

WORKDIR /app

EXPOSE 4000

CMD ["MIX_ENV=prod", "mix", "phx.server"]