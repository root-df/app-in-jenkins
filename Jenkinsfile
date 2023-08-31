pipeline {
    agent any
    tools{
        maven 'M2_HOME'
    }
    environment {
        registry = '967280042115.dkr.ecr.us-east-1.amazonaws.com/w16'
        registryCredential = 'jenkins-ecr'
        dockerimage = ''
    }
    stages {
        stage('Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/root-df/app-in-jenkins.git'
            }
        }
        stage('SonarQube scan'){
          steps{
              withSonarQubeEnv('SonarQube') {
              sh 'mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=root-df_app-in-jenkins'  
          }
        }
        }
        stage('Code Build') {
            steps {
                sh 'mvn clean install package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build Image') {
            steps {
                script{
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                } 
            }
        }
        stage('Deploy image') {
            steps{
                script{ 
                    docker.withRegistry("https://"+registry,"ecr:us-east-1:"+registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }  
    }
}