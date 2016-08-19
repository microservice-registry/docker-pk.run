# Check utilities
command -v docker >/dev/null 2>&1 || { echo >&2 "I require docker but it's not installed.  Aborting."; exit 1; }
command -v cookiecutter >/dev/null 2>&1 || { echo >&2 "I require cookiecutter but it's not installed.  Aborting."; exit 1; }

# Cleaning
if [ -d system_footprint ]
then
    rm -rf system_footprint
fi
if [ $# -eq 0 ]
then
    echo "Install master"
    cookiecutter https://github.com/microservice-registry/docker-pk --config-file config.yaml
else
    echo "Install development"
    cookiecutter https://github.com/microservice-registry/docker-pk --checkout development --config-file config.yaml
fi

# Launch
cd system_footprint && sh gitinit.sh && docker build -t scan .
exit 0
