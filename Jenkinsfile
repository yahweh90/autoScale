pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1' // Specify your AWS region
    }
    stages {
        stage('Set AWS Credentials') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS_SECRET_ACCESS_KEY' // Replace with your Jenkins credential ID
                ]]) {
                    sh '''
                    echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
                    aws sts get-caller-identity // Test AWS credentials
                    '''
                }
            }
        }
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/derrickSh43/autoScale' // Replace with your Git repository URL
            }
        }
        stage('Initialize Terraform') {
            steps {
                sh '''
                terraform init
                '''
            }
        }
        stage('Validate Terraform') {
            steps {
                sh '''
                terraform validate
                '''
            }
        }
        stage('Plan Terraform') {
            steps {
                sh '''
                terraform plan -out=tfplan
                '''
            }
        }
        stage('Apply Terraform') {
            steps {
                input message: "Approve Terraform Apply?", ok: "Deploy"
                sh '''
                terraform apply -auto-approve tfplan
                '''
            }
        }
    }
    post {
        success {
            echo 'Terraform deployment completed successfully!'
        }
        failure {
            echo 'Terraform deployment failed!'
        }
    }
}
