pipeline {
    agent any
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
                sh 'mvn clean install' // sh for linux and ios
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
    }
}