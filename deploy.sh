#!/bin/bash
set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <backend_image> <frontend_image>"
  exit 2
fi

BACKEND_IMAGE=$1
FRONTEND_IMAGE=$2

docker pull "$BACKEND_IMAGE"
docker pull "$FRONTEND_IMAGE"

TEMPLATE=/home/ubuntu/deploy/docker-stack.tpl.yml
TARGET=/home/ubuntu/deploy/docker-stack.yml

if [ ! -f "$TEMPLATE" ]; then
  echo "Template $TEMPLATE not found"
  exit 3
fi

sed "s|BACKEND_IMAGE|$BACKEND_IMAGE|g; s|FRONTEND_IMAGE|$FRONTEND_IMAGE|g" "$TEMPLATE" > "$TARGET"

docker stack deploy -c "$TARGET" app
