pipeline {
    agent {
        docker {
            image 'maven:3.9.0-eclipse-temurin-11-focal'
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
                // sh "apt-get install ssh -y"
                // withCredentials([usernamePassword(credentialsId: 'ci-github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                //         sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/my-org/my-repo.git')
                //     }
                // sshagent(['laptop-macbook']) 
                // {
                //     sh('git push') 
                // }
                withCredentials([usernamePassword(credentialsId: 'username-password-github', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]){
                    sh('''
                        git config --local user.email "geronimo794@gmail.com"
                        git config --local user.name "Ach Rozikin"
                        git config --local credential.helper "!f() { echo username=\\$GIT_USERNAME; echo password=\\$GIT_PASSWORD; }; f"
                        git branch -b
                        git add .
                        git commit -m "Jenkins Build Success"
                        git push -u origin master

                    ''')
                }
            }
        }

    }
}
