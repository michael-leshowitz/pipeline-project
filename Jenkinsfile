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
                        updateGitlabCommitStatus name: 'Build', state: 'failed'
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
                        updateGitlabCommitStatus name: 'Test', state: 'failed'
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
                         sh './jenkins/reset-permission/reset.sh'
                 }
                success {
                         updateGitlabCommitStatus name: 'Deploy', state: 'success'
                }
                failure {
                          updateGitlabCommitStatus name: 'Deploy', state: 'failed'
                }
            }

        }
    }
}
