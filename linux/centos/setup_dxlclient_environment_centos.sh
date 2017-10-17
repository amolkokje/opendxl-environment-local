# INSTRUCTIONS TO RUN:
# 1 --> copy this script to centos machine
# 2 --> chmod 775 script_name.sh
# 3 --> ./script_name.sh


function log() {
    echo "$( date '+[%F_%T]' )" "${HOSTNAME}:" "${LOG_PREFIX}:" "$@"
}

function to_log() {
    while read LINE; do
        log "${LINE}"
    done
}

function run() {
    log RUN: "$@"
    "$@" 2>&1 | to_log
    RETURN_CODE=${PIPESTATUS[0]}
    if [[ ${RETURN_CODE} -ne 0 ]]; then
        log FAILED with RETURN_CODE=${RETURN_CODE}
        exit ${RETURN_CODE}
    fi
    return ${RETURN_CODE}
}
# NOTE: 'cd' command does not work with run()


curl https://raw.githubusercontent.com/amolkokje/python_env_setup/master/centos_setup/centos_setup.sh > centos_env_setup.sh
run chmod 775 centos_env_setup.sh
run ./centos_env_setup.sh
read -p "ENTER TO CONTINUE ..."

run source $HOME/.bashrc
mkvirtualenv dxlclient
# upgrade pip from 3.*(which comes with the environment to latest)
pip install --upgrade pip
pip install -r dxlclient_requirements.txt
deactivate
