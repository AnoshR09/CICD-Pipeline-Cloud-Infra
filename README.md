# 🚀 End-to-End DevOps Project: CI/CD + Terraform + AWS + Docker + Kubernetes

## 📌 Overview
This project is part of my **45-Day DevOps Transformation Challenge**.  
It demonstrates an end-to-end DevOps pipeline including:

- Infrastructure provisioning using **Terraform**  
- Containerization using **Docker**  
- CI/CD using **GitHub Actions / Jenkins**  
- Deployment on **AWS (EC2/EKS)**  
- Monitoring with **Prometheus + Grafana**  
- Version-controlled, modular, production-style DevOps workflows  

---

### Completed:
## 🧱 Terraform Infrastructure (Day 1–3)
- [x] Terraform project initialized  
- [x] VPC creation  
- [x] Subnets creation  
- [x] Internet Gateway 

(Day 2)
### Completed:
## 🧱 Terraform Infrastructure
- [x] Route Tables
- [x] Associated Subnets with route table  
- [x] Security Groups

## 🐳 Docker
- [x] Selected sample application  
- [x] Dockerfile written  
- [x] Container built and tested locally

## 📅 Day 3 Progress — DevOps Transformation Challenge

### ✔ CI Pipeline (GitHub Actions)
- Implemented a CI workflow under `.github/workflows/ci.yml`
- Automated Docker image build on every push to `main`
- Added basic workflow structure for future tests and artifact handling

### ✔ AWS ECR Integration
- Created an Amazon ECR repository for storing application container images
- Successfully authenticated and pushed the Docker image to ECR
- Prepared the image for deployment in upcoming Terraform workflows

### ✔ Terraform Infrastructure Enhancements
- Added IAM Role configuration for EC2 instance access (SSM, CloudWatch, ECR read access)
- Integrated IAM role setup into Terraform module structure
- Updated `main.tf` and supporting files accordingly

### ✔ Repository & Documentation
- Updated README and code structure to reflect new components
- Committed all Day 3 changes to GitHub
