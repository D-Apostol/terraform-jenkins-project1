pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }

    parameters {
        string(name: 'CONSUL_STATE_PATH', defaultValue: 'networking/state/globo-primary', description: 'Path in Consul for state data')
        string(name: 'WORKSPACE', defaultValue: 'development', description:'workspace to use in Terraform')
    }

    environment {
        TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = "TRUE"
        //TF_VAR_consul_address = "host.docker.internal"
        TF_LOG = "WARN"
        //CONSUL_HTTP_TOKEN = credentials('networking_consul_token')
        //AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        //AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        PATH = "$TF_HOME:$PATH"
    }

    stages {
        stage('NetworkInit'){
            steps {
                sh 'terraform --version'
                sh "terraform init"
            }
        }
        stage('NetworkValidate'){
            steps {
                sh 'terraform validate'
            }
        }
        stage('NetworkPlan'){
            steps {
                script{
                    sh "terraform plan -out terraform-jenkins.tfplan;echo \$? > status"
                    stash name: "terraform-jenkins-plan", includes: "terraform-jenkins.tfplan"
                }
            }
        }
        stage('NetworkApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'confirm apply', ok: 'Apply Config'
                        apply = true
                    } catch (err) {
                        apply = false
                        sh "terraform destroy -auto-approve"
                        currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        unstash "terraform-jenkins-plan"
                        sh 'terraform apply terraform-jenkins.tfplan'
                    }
                }
            }
        }
    }
}
    stages {
        stage('deploy') {
            steps {
              sh "aws configure set region $AWS_DEFAULT_REGION" 
              sh "aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID"  
              sh "aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY"
              sh "aws s3 cp index.html s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/css/reset.css s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/css/styles.css s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/images/logo.png s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/images/adobo1.jpg s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/images/adobo2.jpeg s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/images/karekare.jpg s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/images/lechon.jpg s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/images/lumpia.jpg s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/images/pancit.jpg s3://static-bucket-jenkins"
              sh "aws s3 cp ./resources/images/filipinoman.jpg s3://static-bucket-jenkins"
            }
        }
    }
}