pipeline {
  agent any
    stages {
      stage('assemble') {
        steps {
          sh 'as src/transpose.asm && rm a.out'
        }
      }
    }
}