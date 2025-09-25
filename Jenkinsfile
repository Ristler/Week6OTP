pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS_ID = 'docker_hub'   // Your Jenkins Docker Hub credentials ID
        DOCKERHUB_REPO = 'ristler/week6tp1'       // Docker Hub repository
        DOCKER_IMAGE_TAG = 'latest'               // Docker image tag
    }
    tools {
        maven 'Maven 3.9.11'
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Ristler/Week6OTP'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Code Coverage') {
            steps {
                sh 'mvn jacoco:report'
            }
        }

        stage('Publish Test Results') {
            steps {
                junit '**/target/surefire-reports/*.xml'
            }
        }

        stage('Publish Coverage Report') {
            steps {
                jacoco()
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        # Login to Docker Hub using credentials from Jenkins
                        /Applications/Docker.app/Contents/Resources/bin/docker login -u $DOCKER_USER --password-stdin <<< "$DOCKER_PASS"

                        # Build the Docker image
                        /Applications/Docker.app/Contents/Resources/bin/docker build -t $DOCKERHUB_REPO:$DOCKER_IMAGE_TAG .

                        # Push the Docker image to Docker Hub
                        /Applications/Docker.app/Contents/Resources/bin/docker push $DOCKERHUB_REPO:$DOCKER_IMAGE_TAG
                    '''
                }
            }
        }
    }
}