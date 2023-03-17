pipeline {
    agent any
       stages {
        stage('Download Repo') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/ksnithya/jenkins.git'
            }
        }
//        def ret = sh(script: 'uname', returnStdout: true)
//println ret

        stage('Delete Container') {
            steps {
                script {
                    //def ret = sh(script: 'uname', returnStdout: true)
                    //println ret
                    def x = sh(script: "docker ps -a | grep nithya-container | wc -l", returnStdout: true)
                    println x
                    if (x.toInteger() > 0){
                        sh 'docker stop nithya-container'
                        sh 'docker rm nithya-container'
                    }
                }
            }
        }
        stage('Image Delete') {
            steps {
                script {
                    if (sh(script: "docker images | grep nithya-resume | wc -l", returnStdout: true).toInteger() > 0){
                        sh 'docker rmi nithyaks/nithya-resume:latest'
                    }
                }
            }
        }        
        stage('Image Build') {
            steps {
                // img = sh("docker inspect nithya:v1 > /dev/null 2>&1 && echo yes || echo no")
                // sh "echo 'output: ${img}'"
                sh 'docker build -t nithyaks/nithya-resume:latest .'
            }
        }
        stage('Image Pull') {
            steps {
                script {
                    withCredentials([usernamePassword( credentialsId: 'DockerHub', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                        def registry_url = "registry.hub.docker.com"
                        sh 'docker logout'
                        sh 'docker login -u $USER -p $PASSWORD ${registry_url}'
                        //docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {
                        sh 'docker push nithyaks/nithya-resume:latest'
                        //}  
                    }
                }
            }
        }
        stage('Build Container') {
            steps {
                // img = sh("docker inspect nithya:v1 > /dev/null 2>&1 && echo yes || echo no")
                // sh "echo 'output: ${img}'"
                sh 'docker run -d --name nithya-container -p 8000:80 nithyaks/nithya-resume:latest'
            }
        }
    }
}

