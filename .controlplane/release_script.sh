#!/bin/bash -e

echo 'Running release_script.sh per controlplane.yml'

echo 'Run DB migrations'
./bin/rails db:prepare

echo 'Completed release_script.sh per controlplane.yml'