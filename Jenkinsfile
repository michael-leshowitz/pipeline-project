pipeline {
    agent any
    environment {
     PASS = credentials("registry-pass")
    }
    stages {
        stage('Build') {
            steps {
                sh '''
			./jenkins/build/mvn.sh mvn -B -DskipTests -e -Denforcer.skip=true clean package
			./jenkins/build/build.sh
			
		'''
            }
        }
        stage('Test') {
            steps {
            	sh '''
			./jenkins/test/test.sh mvn -Denforcer.skip=true test
		'''
            }            
        }
        stage('Push') {
            steps {
                sh './jenkins/push/push.sh'
            }            
        }
        stage('Depoly') {
            steps {
                sh '.jenkins/deploy/deploy.sh'
            }
        }
    }
}
