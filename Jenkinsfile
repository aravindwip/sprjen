pipeline {
    agent any

    tools {
        jdk 'Java17'          // Jenkins global JDK tool
        maven 'Maven-home'    // Jenkins global Maven tool
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Pulling from Github'
                git branch: 'main', credentialsId: 'mygithubcred', url: 'https://github.com/aravindwip/wipjen.git'
            }
        }

        stage('Test Code') {
            steps {
                echo 'Running JUnit tests for Spring Boot project'
                bat 'mvn clean test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                    echo 'Test Run completed!'
                }
            }
        }

        stage('Build Project') {
            steps {
                echo 'Building Spring Boot project'
                // package with Spring Boot plugin so JAR is executable
                bat 'mvn clean package -DskipTests spring-boot:repackage'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image for Spring Boot app'
                bat 'docker build -t springboot-app:1.0 .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Spring Boot Application in Docker'
                bat '''
                docker rm -f springboot-app-container || exit 0
                docker run -d -p 8080:8080 --name springboot-app-container springboot-app:1.0
                '''
            }
        }
    }

    post {
        success {
            echo 'Build and Run SUCCESSFUL! Access app at http://localhost:8080/hello'
        }
        failure {
            echo 'OOPS!!! Build or Run failed.'
        }
    }
}
