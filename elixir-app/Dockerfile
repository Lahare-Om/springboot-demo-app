FROM elixir:1.14-alpine AS builder
WORKDIR /app
COPY mix.exs mix.lock* ./
RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get && mix deps.compile
COPY . .
RUN mix escript.build

FROM alpine:latest
RUN apk add --no-cache openssl
WORKDIR /app
COPY --from=builder /app/elixir_app ./
EXPOSE 8080
CMD ["./elixir_app"]
