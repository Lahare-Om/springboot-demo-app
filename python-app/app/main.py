"""FastAPI application for Python demo app."""
from fastapi import FastAPI
from fastapi.responses import JSONResponse
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="Python Demo App",
    description="Demo Python service for local Docker/K8s/ArgoCD exercises",
    version="0.1.0"
)


@app.get("/", tags=["Health"])
async def root():
    """Root endpoint."""
    return {"message": "Python demo app is running"}


@app.get("/health", tags=["Health"])
async def health():
    """Health check endpoint."""
    logger.info("Health check requested")
    return JSONResponse(
        status_code=200,
        content={
            "status": "healthy",
            "service": "python-demo-app",
            "version": "0.1.0"
        }
    )


@app.get("/api/info", tags=["Info"])
async def info():
    """Application info endpoint."""
    return {
        "name": "python-demo-app",
        "version": "0.1.0",
        "description": "Demo Python service for local Docker/K8s/ArgoCD exercises",
        "runtime": "Python 3.11+"
    }


@app.get("/api/echo/{message}", tags=["Echo"])
async def echo(message: str):
    """Echo back the provided message."""
    logger.info(f"Echo requested for message: {message}")
    return {
        "original": message,
        "echoed": message,
        "timestamp": __import__("datetime").datetime.utcnow().isoformat()
    }


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
