pipeline {
    agent any
    
    environment {
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
		withCredentials([file(credentialsId: 'terraform-wordpress-key', variable: 'key_file')]) {
	        sh "cp ${key_file} wordpress_key"
                sh "chmod 600 wordpress_key"  
   		    }
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

