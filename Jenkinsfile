pipeline {
    agent any
    
    environment {
        private_key = credentials('terraform-key-wordpress')
	AWS_ACCESS_KEY_ID = credentials('aws-access-key')
	AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }

    stages {
        stage('Install boto for dynamic inventory') {
            steps {
               sh 'pip install boto'                
            }
        }
        stage('Create private key file for ansible'){
            steps {
	        sh "echo ${private_key} > wordpress_key"
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
	    stage('Terraform apply'){
		    steps {
			    dir('terraform') {
				    sh 'terraform apply -auto-approve'
			    }
		    }
	    }
 
    }
   
}

