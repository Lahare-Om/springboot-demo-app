const assert = require("node:assert/strict");

const { createServer } = require("../src/server");

async function withServer(run) {
  const server = createServer();
  await new Promise((resolve) => server.listen(0, "127.0.0.1", resolve));
  const address = server.address();
  const baseUrl = `http://127.0.0.1:${address.port}`;

  try {
    await run(baseUrl);
  } finally {
    await new Promise((resolve, reject) => {
      server.close((error) => (error ? reject(error) : resolve()));
    });
  }
}

async function testHealthEndpoint() {
  await withServer(async (baseUrl) => {
    const response = await fetch(`${baseUrl}/health`);
    const body = await response.json();

    assert.equal(response.status, 200);
    assert.equal(body.status, "healthy");
    assert.equal(body.service, "node-demo-app");
  });
}

async function testInfoEndpoint() {
  await withServer(async (baseUrl) => {
    const response = await fetch(`${baseUrl}/api/info`);
    const body = await response.json();

    assert.equal(response.status, 200);
    assert.equal(body.name, "node-demo-app");
    assert.equal(body.version, "0.1.0");
  });
}

async function testEchoEndpoint() {
  await withServer(async (baseUrl) => {
    const response = await fetch(`${baseUrl}/api/echo/hello%20node`);
    const body = await response.json();

    assert.equal(response.status, 200);
    assert.equal(body.original, "hello node");
    assert.equal(body.echoed, "hello node");
  });
}

async function main() {
  await testHealthEndpoint();
  await testInfoEndpoint();
  await testEchoEndpoint();
  console.log("Node app tests passed.");
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
