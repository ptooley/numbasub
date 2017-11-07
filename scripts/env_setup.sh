#!/bin/bash

get_script_path () {
  scriptpath=$(readlink -f $PWD/$)
  echo $scriptpath
}

conda_check () {
  conda_path=$(which conda 2>/dev/null)
  return $?
}

conda_env_exists () {
  matches=$(conda env list | awk '{print $1}' | grep -E "^$1$" )
  return $?
}

conda_setup_env () {
  envname=$1
  if conda_env_exists ${envname}; then
    echo -e "Using existing conda environment ${envname}" >&2
    echo -e "Updating pyShIRT..." >&2
    source activate ${envname}
    pip install --upgrade .>&2
    source deactivate
  else
    echo -e "Setting up conda environment ${envname}:\n" >&2
    #get dir of script
    script_dir=$(dirname get_script_path)
    conda env create -n ${envname} -f $script_dir/intelpy_env.yml >/dev/null
    source activate ${envname}
    pip install .>&2
    source deactivate
  fi
  
  sourcepath="$(dirname $(which conda) )/activate ${envname}"
  echo -e "\nDone.\n" >&2
  echo ${sourcepath}
}

virtualenv_check () {
  venv_path=$(which virtualenv 2>/dev/null)
  return $?
}

virtualenv_setup_env () {
  venv_name=$1
  if [ ! -d $venv_name ]; then
    echo -e "Setting up virtualenv $venv_name..." >&2
    virtualenv $venv_name >&2 
    source $venv_name/bin/activate >&2
    pip install -r requirements.txt >&2
    pip install . >&2
    deactivate >&2
  else
    echo -e "Using existing virtualenv $venv_name..." >&2
    source $venv_name/bin/activate >&2
    pip install --upgrade . >&2 
    deactivate >&2
  fi

  sourcepath="$venv_name/bin/activate"
  echo ${sourcepath} >&2
  echo ${sourcepath}
  return 0
}
  

get_env_path () {
  if conda_check &>/dev/null; then
    sourcepath=$(conda_setup_env $1 )
    echo $sourcepath
    return 0
  elif virtualenv_check; then
    sourcepath=$(virtualenv_setup_env $1)
    echo $sourcepath
    return 0
  else
    echo "Error, need either virtualenv or conda to deploy test framework." >&2
    return -1
  fi
}


