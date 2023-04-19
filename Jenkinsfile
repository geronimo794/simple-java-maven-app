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
                input message: 'Lanjutkan ke tahap Deploy?' 

            }
        }
        stage('Deploy') {
            sh './jenkins/scripts/deliver-local.sh'
            sh './jenkins/scripts/wait.sh'
        }
    }
    stage('Public Deploy') {
        // Using SSH Agent connection
        sshagent(['laptop-macbook']) 
        {
            // Change local workspace jenkins
            // And set from local SCM to origin github
            // Push to origin github
            sh('''
                git config --local user.email "geronimo794@gmail.com"
                git config --local user.name "Ach Rozikin"
                git config --local credential.helper "!f() { echo username=\\$GIT_USERNAME; echo password=\\$GIT_PASSWORD; }; f"
                git remote set-url origin git@github.com:geronimo794/simple-java-maven-app.git
                git push origin HEAD:master
            ''')
        } 
    }
}
