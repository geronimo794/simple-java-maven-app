node {
    stage('Build') {
        docker.image('maven:3.9.0-eclipse-temurin-11').
        withRun('-v /root/.m2:/root/.m2').
        inside {
            sh 'mvn -B -DskipTests clean package'
        }
    }
}
