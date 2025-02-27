# Variables
APP_NAME = src.main.py
HOST = 0.0.0.0
PORT = 8000
TEST_DIR = tests

# Install dependencies
install:
	pip install -r src/requirements.txt

# Run the FastAPI application
run:
	uvicorn $(APP_NAME):app --host $(HOST) --port $(PORT) --reload

# Run tests
test:
	pytest test_main.py --disable-warnings

# Format code using Black
format:
	black src

# Lint code using Flake8
lint:
	flake8 src

# Remove __pycache__ and temporary files
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

# Run all checks
check: lint format test


# Docker Commands
docker-build:
	docker build -t $(IMAGE_NAME) .

docker-run:
	docker run -p 8000:8000 $(IMAGE_NAME)

docker-clean:
	docker rmi -f $(IMAGE_NAME)

.PHONY: install run test format lint clean check docker-build docker-run docker-clean
