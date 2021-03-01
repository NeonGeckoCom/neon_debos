pipeline {
    agent any 

    stages {
        stage('Image') {
            agent any 
            steps {
              sh 'docker run --rm --device /dev/kvm --user $(id -u) --workdir /recipes --mount "type=bind,source=$(pwd),destination=/recipes" --group-add=$(getent group kvm | cut -d : -f 3) --security-opt label=disable godebos/debos ovos-dev-edition-rpi4.yml  -t architecture:arm64 -m 10G'
            }
        }
    }
}
