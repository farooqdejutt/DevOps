pipeline {
    agent { label 'slave'}

    environment {
        DOCKER_HUB_REPO = 'farooqdevops/my-node-app' // Replace with your Docker Hub repo
        DOCKER_HUB_CREDENTIALS_ID = 'docker-hub' // Jenkins credentials ID for Docker Hub
        IMAGE_TAG = "latest" // This can be dynamic, like using a commit hash or build number
        NEW_IMAGE_TAG = "v3.0.0" // Replace with the tag version you want to use
    }

    stages {

        stage('Build Docker Image') {
            steps {
                script {
                    dir('docker') {
                    sh 'ls -l'
                    // Build Docker image using Dockerfile in the current directory
                    sh "docker build -t ${DOCKER_HUB_REPO}:${IMAGE_TAG} ."
                    }
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    // Tag the image with a new version or tag
                    sh "docker tag ${DOCKER_HUB_REPO}:${IMAGE_TAG} ${DOCKER_HUB_REPO}:${NEW_IMAGE_TAG}"
                }
            }
        }

        stage('Login and Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub and push both the latest and the new tag
                    withCredentials([usernamePassword(credentialsId: DOCKER_HUB_CREDENTIALS_ID, usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        // Login to Docker Hub
                        sh 'docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD'

                        // Push both tags (latest and new version)
                        sh "docker push ${DOCKER_HUB_REPO}:${NEW_IMAGE_TAG}"
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images from the Jenkins agent to save space
            sh "docker rmi ${DOCKER_HUB_REPO}:${IMAGE_TAG} || true"
            sh "docker rmi ${DOCKER_HUB_REPO}:${NEW_IMAGE_TAG} || true"
        }
    }
}
