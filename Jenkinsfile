node {
    docker.image('maven:3.9.0-eclipse-temurin-11').args('-v /root/.m2:/root/.m2').inside {
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
    }
}
