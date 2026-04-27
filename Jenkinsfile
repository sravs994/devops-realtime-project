pipeline {
    agent { label 'dev' }

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO = '857481978652.dkr.ecr.us-east-1.amazonaws.com/devops-realtime-repo'
        IMAGE_TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
        ECR_REGISTRY = '857481978652.dkr.ecr.us-east-1.amazonaws.com'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}",
                url: 'https://github.com/sravs994/devops-realtime-project.git'
            }
        }

        stage('Parallel Checks') {
            parallel {
                stage('Unit Test') {
                    steps { sh 'echo Running tests...' }
                }
                stage('Lint') {
                    steps { sh 'echo Linting...' }
                }
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $ECR_REPO:$IMAGE_TAG .'
            }
        }

        stage('Push to ECR') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'main'
                }
            }
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin $ECR_REGISTRY

                docker push $ECR_REPO:$IMAGE_TAG
                '''
            }
        }
    }
}