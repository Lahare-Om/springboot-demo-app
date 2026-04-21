FROM rust:1.89-alpine AS builder
RUN apk add --no-cache musl-dev
WORKDIR /app
COPY Cargo.toml .
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release
COPY src src
RUN touch src/main.rs && cargo build --release

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/target/release/rust-api .
EXPOSE 8080
CMD ["./rust-api"]
