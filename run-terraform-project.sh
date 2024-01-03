#!/usr/bin/env bash

scriptpath=$(dirname $(readlink -f $0))
dir=$(readlink -f $scriptpath)

case $1 in
  "--prepare")
    source $dir/run-terraform-project/prepare.sh
    ;;
  "--init")
    source $dir/run-terraform-project/init.sh
    ;;
  "--plan")
    source $dir/run-terraform-project/plan.sh
    ;;
  "--apply")
    source $dir/run-terraform-project/apply.sh
    ;;
  *)
    echo "Running all stages"
    source $dir/run-terraform-project/prepare.sh
    source $dir/run-terraform-project/init.sh
    source $dir/run-terraform-project/plan.sh
    source $dir/run-terraform-project/apply.sh
    ;;
esac
