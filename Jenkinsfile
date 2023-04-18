pipeline {
    agent {
        docker {
            image 'maven:3.9.0-eclipse-temurin-11'
            args '-v /root/.m2:/root/.m2 -p 8080:8080'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                    // Add button confirmation to deploy
                    input message: 'Lanjutkan ke tahap Deploy?' 

                }
            }
        }
        stage('Local Deploy') {
            steps {
                sh './jenkins/scripts/deliver-local.sh'
                sh './jenkins/scripts/wait.sh'
            }
        }
        stage('Public Deploy') {
            steps {
                sh "apk --update add openssh-client"
                withCredentials([usernamePassword(credentialsId: 'ci-github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/my-org/my-repo.git')
                    }


            }
        }

    }
}
