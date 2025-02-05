pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Creating virtual environment and installing dependencies...'
                // If you still need to set up a virtual environment for some reason
                // You can also choose to remove this stage if Docker is the primary environment
                sh 'python3 -m venv venv'
                sh './venv/bin/pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'python3 -m unittest discover -s .'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                // Build the Docker image using the Dockerfile
                sh 'docker build -t python-app .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh '''
                mkdir -p ${WORKSPACE}/python-app-deploy
                cp ${WORKSPACE}/app.py ${WORKSPACE}/python-app-deploy/
                '''
            }
        }

        stage('Run Application in Docker') {
            steps {
                echo 'Running application in Docker...'
                // Run the Docker container
                sh 'docker run -d -p 5000:5000 --name python-app python-app'
            }
        }

        stage('Test Application') {
            steps {
                echo 'Testing application...'
                sh '''
                python3 ${WORKSPACE}/test_app.py
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for more details.'
        }
    }
}
