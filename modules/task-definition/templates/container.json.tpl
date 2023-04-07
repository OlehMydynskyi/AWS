[
  {
    "name": "${APPLICATION}",
    "image": "${REPOSITORY_URL}:${DOCKER_TAG}",
    "portMappings": [
      {
        "containerPort": 8080,
        "protocol": "tcp"
      }
    ]
  }
]