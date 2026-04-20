use actix_web::{web, App, HttpResponse, HttpServer};
use serde::Serialize;
use std::env;

#[derive(Serialize)]
struct Message {
    message: String,
    version: String,
}

#[derive(Serialize)]
struct Health {
    status: String,
    hostname: String,
}

async fn index() -> HttpResponse {
    HttpResponse::Ok().json(Message {
        message: "Hello from Rust API".to_string(),
        version: "1.0.0".to_string(),
    })
}

async fn health() -> HttpResponse {
    let hostname = env::var("HOSTNAME").unwrap_or_else(|_| "unknown".to_string());
    HttpResponse::Ok().json(Health {
        status: "healthy".to_string(),
        hostname,
    })
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    println!("Rust API starting on port 8080");

    HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(index))
            .route("/health", web::get().to(health))
    })
    .bind("0.0.0.0:8080")?
    .run()
    .await
}
