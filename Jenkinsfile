pipeline {
  agent any
    stages {
      stage('assemble') {
        steps {
            sh 
            """
            for file in /src/*.asm
            do
                as "$file"
            done
            """
            sh 'rm src/a.out'
        }
      }
    }
}