pipeline {
    agent any
    
    environment {
        private_key = 'terraform-key-wordpress'
    }

    stages {
        stage('Pull code from repo') {
            steps {
                //git config
                git credentialsId: git_credential, url: 'https://github.com/grhovo/epam-terraform.git'
                
            }
        }
        stage('Create private key file for ansible'){
            steps {
                awsIdentity()
                writeFile file: wordpress_key, text: private_key, perms='600'               
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

