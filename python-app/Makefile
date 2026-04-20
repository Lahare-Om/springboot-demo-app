# Makefile for Python Demo App

.PHONY: help install dev test lint format clean build run docker-build docker-run

help:
	@echo "Python Demo App - Available commands:"
	@echo ""
	@echo "  make install       - Install dependencies"
	@echo "  make dev          - Install dev dependencies and run in reload mode"
	@echo "  make test         - Run unit tests"
	@echo "  make test-cov     - Run tests with coverage report"
	@echo "  make lint         - Run code linting (flake8)"
	@echo "  make format       - Format code with black"
	@echo "  make clean        - Clean up build artifacts and caches"
	@echo "  make run          - Run the application"
	@echo "  make docker-build - Build Docker image"
	@echo "  make docker-run   - Run Docker container"
	@echo ""

install:
	pip install -r requirements.txt

dev:
	pip install -r requirements.txt
	python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

test:
	pytest tests/

test-cov:
	pytest --cov=app tests/

lint:
	flake8 app tests

format:
	black app tests

clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf .pytest_cache .coverage htmlcov dist build *.egg-info

run:
	python -m uvicorn app.main:app --host 0.0.0.0 --port 8000

docker-build:
	docker build -t python-demo-app:0.1.0 .

docker-run:
	docker run -p 8000:8000 python-demo-app:0.1.0
