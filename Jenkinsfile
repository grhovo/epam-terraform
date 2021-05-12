pipeline {
    agent any
    
    environment {
        private_key = 'terraform-key-wordpress'
    }

    stages {
        stage('Pull code from repo') {
            steps {
                //git config
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git-credential', url: 'https://github.com/grhovo/epam-terraform.git']]])
                
            }
        }
        stage('Create private key file for ansible'){
            steps {
                awsIdentity()
		sh "echo $private_key > wordpress_key"
                sh "chmod 600 wordpress_key"            
            }
        }
        stage('Terraform init'){
           steps {
                dir('terraform') {
                    sh 'terraform init'
                }
	}       
        }
 
    }
   
}

