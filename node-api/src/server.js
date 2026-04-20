const http = require("node:http");

const HOST = process.env.HOST || "0.0.0.0";
const PORT = Number.parseInt(process.env.PORT || "3000", 10);
const APP_NAME = process.env.APP_NAME || "node-demo-app";
const APP_VERSION = process.env.APP_VERSION || "0.1.0";
const ENVIRONMENT = process.env.ENVIRONMENT || "local";

function sendJson(res, statusCode, payload) {
  res.writeHead(statusCode, { "Content-Type": "application/json" });
  res.end(JSON.stringify(payload));
}

function createServer() {
  return http.createServer((req, res) => {
    const url = new URL(req.url || "/", `http://${req.headers.host || "localhost"}`);

    if (req.method === "GET" && url.pathname === "/") {
      return sendJson(res, 200, { message: "Node demo app is running" });
    }

    if (req.method === "GET" && url.pathname === "/health") {
      return sendJson(res, 200, {
        status: "healthy",
        service: APP_NAME,
        version: APP_VERSION
      });
    }

    if (req.method === "GET" && url.pathname === "/api/info") {
      return sendJson(res, 200, {
        name: APP_NAME,
        version: APP_VERSION,
        runtime: process.version,
        environment: ENVIRONMENT
      });
    }

    if (req.method === "GET" && url.pathname.startsWith("/api/echo/")) {
      const message = decodeURIComponent(url.pathname.replace("/api/echo/", ""));
      return sendJson(res, 200, {
        original: message,
        echoed: message,
        timestamp: new Date().toISOString()
      });
    }

    return sendJson(res, 404, { error: "Not found" });
  });
}

if (require.main === module) {
  const server = createServer();
  server.listen(PORT, HOST, () => {
    console.log(`${APP_NAME} listening on ${HOST}:${PORT}`);
  });
}

module.exports = { createServer };
