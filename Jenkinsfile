pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1' // Specify your AWS region
        TF_VAR_ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID') // Jenkins credential for AWS access key
        TF_VAR_SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY') // Jenkins credential for AWS secret key
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo.git' // Replace with your Git repository URL
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
