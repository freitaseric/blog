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

RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix deps.get

COPY . .

RUN MIX_ENV=prod mix compile

FROM base AS runtime

WORKDIR /app

RUN apt-get update && apt-get install -y \
  ca-certificates \
  openssl \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/_build/prod/rel/blog /app/rel/blog
COPY --from=builder /app/priv /app/priv

HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD /app/rel/blog/bin/blog eval "BlogWeb.Repo.query!('SELECT 1')" || exit 1

EXPOSE 4000

CMD ["/app/rel/bloc/bin/blog", "start"]