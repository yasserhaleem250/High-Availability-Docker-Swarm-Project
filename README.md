# CI/CD-Driven Docker Swarm Deployment on AWS

This repository contains examples and documentation for provisioning a two-node Docker Swarm cluster on AWS EC2 and deploying containerized applications via a Git-based CI/CD pipeline.

Overview
--------
- Multi-node Docker Swarm (manager + worker) on AWS EC2.
- GitHub Actions builds Docker images and deploys to the Swarm manager over SSH.

Architecture
------------
- Manager: Swarm manager and deployment target.
- Worker: Swarm worker for scheduling containers.
- CI: GitHub Actions builds and pushes images, then SSHs to the manager to run stack deploy or service updates.

Prerequisites
-------------
- AWS account and IAM credentials
- SSH key pair for EC2 instances
- Docker Hub (or other registry) credentials (optional)
- Terraform and AWS CLI (for provisioning)

Quickstart (high-level)
------------------------
1. Provision two EC2 instances (manager + worker) and a security group that allows SSH and Swarm ports (2377/tcp, 7946/tcp/udp, 4789/udp).
2. Install Docker on both nodes and run `docker swarm init --advertise-addr <MANAGER_IP>` on the manager. Join the worker using the returned token.
3. Place `docker-stack.yml` on the manager and ensure the CI pipeline can SSH to the manager.
4. Configure GitHub Actions secrets: `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`, `SSH_PRIVATE_KEY`, `SWARM_MANAGER_IP`.
5. Push to `main` and let the pipeline build, push, and deploy the new image.

Files included
--------------
- [.github/workflows/ci-cd.yml](.github/workflows/ci-cd.yml)
- [terraform/main.tf](terraform/main.tf)
- [deploy/deploy.sh](deploy/deploy.sh)
- [deploy/docker-stack.yml](deploy/docker-stack.yml)

Security notes
--------------
- Lock down the security group to trusted IPs for SSH where possible.
- Use a private registry or keep images private when appropriate.
- Rotate credentials and use least-privilege IAM policies for automation.

License
-------
Example content — adapt for your environment.
