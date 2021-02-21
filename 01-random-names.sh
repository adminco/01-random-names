#!/bin/bash
curl -s https://reqres.in/api/users?page=1 | jq --raw-output '.data[] | .first_name + " " + .last_name' | sort -R
