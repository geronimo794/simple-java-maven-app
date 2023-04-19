node {
    // This is so important for scripted pipeline
    // Because this will syncronize your code with you SCM
    // If you ever wonder, why your source code not update
    // Maybe because you are not include it on your scripted pipeline
    checkout scm
    
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
                //             sshagent(['laptop-macbook']) 
                // {
                // }

            // sh "sudo apt-get install ssh -y"
            // // withCredentials([usernamePassword(credentialsId: 'ci-github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
            // //         sh('git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/my-org/my-repo.git')
            // //     }
            sshagent(['laptop-macbook']) 
            {
                sh('''
                    git config --local user.email "geronimo794@gmail.com"
                    git config --local user.name "Ach Rozikin"
                    git config --local credential.helper "!f() { echo username=\\$GIT_USERNAME; echo password=\\$GIT_PASSWORD; }; f"
                    git remote set-url origin git@github.com:geronimo794/simple-java-maven-app.git
                    git push origin HEAD:master
                ''')
            } 

            //     sh('git push') 
                    //             git add .
                    // git commit -m "Jenkins Build Success"
                    // git checkout master
                    // git pull

            // withCredentials([usernamePassword(credentialsId: 'username-password-github', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]){
            //     sh('''
            //         git config --local user.email "geronimo794@gmail.com"
            //         git config --local user.name "Ach Rozikin"
            //         git config --local credential.helper "!f() { echo username=\\$GIT_USERNAME; echo password=\\$GIT_PASSWORD; }; f"
            //         git remote set-url origin https://github.com/geronimo794/simple-java-maven-app.git
            //         git push origin HEAD:master
            //     ''')
            // }
        }


}
