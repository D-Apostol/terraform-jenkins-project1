pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }

    environment {
        TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = "TRUE"
        TF_LOG = "WARN"
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