FROM elixir:1.14-alpine
RUN apk add --no-cache build-base
WORKDIR /app
COPY mix.exs mix.lock* ./
RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get
COPY . .
RUN mix deps.compile
EXPOSE 8080
CMD ["mix", "run", "--no-halt"]
