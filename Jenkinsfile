#!/usr/bin/env groovy
node('ubuntu')
{
    properties([[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10']]]);

    // some basic config
    def BASE_IMAGE_NAME = 'gerrit'
    def DOCKER_PRIVATE_REGISTRY = env.DOCKER_PRIVATE_REGISTRY
    
    def IMAGE_TAG         = (env.BRANCH_NAME == 'master'  ? 'latest' : 'dev')
    def IMAGE_ARGS        = '--pull --no-cache .'

    def DOCKERHUB_USERNAME = 'NotDefined'
    
    def app
 
    def DOCKER_USERNAME = 'NotDefined'
    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'private-docker-hub-cred',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) 
    {
      DOCKER_USERNAME = USERNAME
    }      
    
    
    stage('Checkout SCM') 
    {
        // Let's make sure we have the repository cloned to our workspace
        checkout scm
    }

    stage('Build image') 
    {
        app = docker.build("${DOCKER_USERNAME}/${BASE_IMAGE_NAME}:${IMAGE_TAG}", "${IMAGE_ARGS}")
    }

    stage('Push image') 
    {
        docker.withRegistry("$DOCKER_PRIVATE_REGISTRY", 'private-docker-hub-cred') 
        {
            app.push("${IMAGE_TAG}")
        }
    }
}
