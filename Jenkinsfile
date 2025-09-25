pipeline {
    agent any
     environment {
                PATH = "C:\\Program Files\\Docker\\Docker\\resources\\bin;${env.PATH}"

                // Define Docker Hub credentials ID
                DOCKERHUB_CREDENTIALS_ID = ''
                // Define Docker Hub repository name
                DOCKERHUB_REPO = ''
                // Define Docker image tag
                DOCKER_IMAGE_TAG = 'latest'
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
       stage('Build Docker Image') {
           steps {
               sh '/Applications/Docker.app/Contents/Resources/bin/docker build -t $DOCKERHUB_REPO:$DOCKER_IMAGE_TAG .'
           }
       }

       stage('Push Docker Image to Docker Hub') {
           steps {
               withCredentials([usernamePassword(
                   credentialsId: "${DOCKERHUB_CREDENTIALS_ID}",
                   usernameVariable: 'DOCKER_USER',
                   passwordVariable: 'DOCKER_PASS')]) {
                   sh '''
                       /Applications/Docker.app/Contents/Resources/bin/docker login -u $DOCKER_USER -p $DOCKER_PASS
                       /Applications/Docker.app/Contents/Resources/bin/docker push $DOCKERHUB_REPO:$DOCKER_IMAGE_TAG
                   '''
               }
           }
       }
    }
}
}