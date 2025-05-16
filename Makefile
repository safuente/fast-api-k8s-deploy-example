# Variables
IMAGE_NAME=test-api
IMAGE_TAG=v1.0.0
CLUSTER_NAME=cluster-test
DEPLOYMENT_NAME=fastapi-app
DEPLOYMENT_FILE=deployment.yaml
DOCKERFILE=test-api/Dockerfile

.PHONY: all build kind-load deploy restart logs port-forward clean

# Build the Docker image
build:
	cd test-api && docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

# Load image into kind cluster
kind-load:
	kind load docker-image $(IMAGE_NAME):$(IMAGE_TAG) --name $(CLUSTER_NAME)

# Apply Kubernetes manifests
deploy:
	kubectl apply -f $(DEPLOYMENT_FILE)

# Restart the deployment (forces new pods)
restart:
	kubectl rollout restart deployment $(DEPLOYMENT_NAME)

# Tail logs of running pods
logs:
	kubectl logs -l app=fastapi -f

# Port-forward service to localhost
port-forward:
	kubectl port-forward service/fastapi-service 8000:80

# Full deploy pipeline
all: build kind-load deploy restart

# Delete everything (careful!)
clean:
	kubectl delete all --all
