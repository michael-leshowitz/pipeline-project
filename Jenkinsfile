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
            post {
                success {
                        archiveArtifacts artifacts: 'java-app/target/*.jar', fingerprint: true
		}
                failure {
                        error "Build step failed, halting pipeline"
                }
		always {
			sh './jenkins/reset-permission/reset.sh'
		}
            }
        }
        stage('Test') {
            steps {
            	sh '''
			./jenkins/test/test.sh mvn -Denforcer.skip=true test
		'''
            }
            post {
                 always {
                        junit 'java-app/target/surefire-reports/*.xml'
			sh './jenkins/reset-permission/reset.sh'
                 }
                 failure {
                        error "Test failed! Halting pipeline"
                 }
            }            
        }
        stage('Push') {
            steps {
                sh './jenkins/push/push.sh'
            }
            post {            
                 always {
                        sh './jenkins/reset-permission/reset.sh'
                 }
            }

        }
        stage('Depoly') {
            steps {
                sh './jenkins/deploy/deploy.sh'
            }
            post {
                always {
		  	 updateGitlabCommitStatus name: 'Deploy', state: 'success'
                         sh './jenkins/reset-permission/reset.sh'
                 }
            }

        }
    }
}
