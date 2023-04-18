node {
    docker.image('maven:3.9.0-eclipse-temurin-11').inside('-v /root/.m2:/root/.m2 -p 8080:8080') {
        stage('Build') {
            sh 'mvn -B -DskipTests clean package'
        }

        stage('Test') {
            try {
                sh 'mvn test'
            }finally {
                junit 'target/surefire-reports/*.xml'
            }
        }
        stage('Local Deploy') {
            sh './jenkins/scripts/deliver-local.sh'
            // sh './jenkins/scripts/wait.sh'

            input message: 'Lanjutkan ke tahap Deploy Github?' 
        }
    }
        stage('Public Deploy') {
            // sh "sudo apt-get install ssh -y"
            // // withCredentials([usernamePassword(credentialsId: 'ci-github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
            // //         sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/my-org/my-repo.git')
            // //     }
            // sshagent(['laptop-macbook']) 
            // {
            //     sh('git push') 
            // }
            withCredentials([usernamePassword(credentialsId: 'username-password-github', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]){
                sh('''
                    git config --local user.email "geronimo794@gmail.com"
                    git config --local user.name "Ach Rozikin"
                    git config --local credential.helper "!f() { echo username=\\$GIT_USERNAME; echo password=\\$GIT_PASSWORD; }; f"
                    git checkout master
                    git add .
                    git commit -m "Jenkins Build Success"
                    git pull
                    git push origin HEAD:master
                ''')
            }
        }


}
