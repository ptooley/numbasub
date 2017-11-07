#!/bin/sh

testmodule="numbasub"

source ./scripts/env_setup.sh
env_name=testenv_${testmodule}

sourcepath=$(get_env_path ${env_name})
source $sourcepath

export PYTHONUNBUFFERED=1
python -m pytest --cov=${testmodule} --cov-report=html:www/coverage
