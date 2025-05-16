# 🚀 Deploying a FastAPI App on a Local Kubernetes Cluster with Kind

This guide explains how to deploy a FastAPI app locally using Docker, uv, and Kind for Kubernetes.

---

## ✅ Prerequisites

Install the following tools:

- **uv** for Python dependency management
- **Docker**, Podman, or Rancher Desktop
- **Kind** for Kubernetes-in-Docker
- **kubectl** to manage the Kubernetes cluster

---

## 🏗️ Step 1: Create a Kind Cluster

Create a `kind.yaml` with 1 control-plane node and 2 worker nodes, mapping port `30000` to host port `8000`.

Create the cluster using:

```bash
kind create cluster --name cluster-test --config kind.yaml
kubectl config use-context kind-cluster-test
kubectl get nodes
```

---

## ⚙️ Step 2: Create the FastAPI App

1. Initialize the project with `uv init`
2. Add FastAPI: `uv add fastapi[standard]`
3. Implement a basic endpoint in `main.py`

---

## 🐳 Step 3: Build the Docker Image

Create a multi-stage `Dockerfile` using `uv` for dependency syncing, then:

```bash
docker build -t test-api:v1.0.0 .
```

---

## 📦 Step 4: Push Image to Kind

Load your local image into the Kind cluster:

```bash
kind load docker-image test-api:v1.0.0 --name cluster-test
```

---

## 📜 Step 5: Deploy with Kubernetes Manifests

Apply a `Deployment` with 2 replicas and a `NodePort` `Service` exposing port `30000`.

```bash
kubectl apply -f deployment.yaml
```

---

## 🛠 Step 6: Automate with a Makefile

Use a `Makefile` to automate build, load, deploy, and logs. Run:

```bash
make all
```

---

## 🧪 Step 7: Test the App

Visit:

- [http://localhost:8000](http://localhost:8000)
- [http://localhost:8000/docs](http://localhost:8000/docs)

Expected output:

```json
{
  "status": "OK",
  "msg": "Hello world!"
}
```

---

## ✅ Done!

You now have a local FastAPI app running in Kubernetes using Kind — ready to scale and test like production.
