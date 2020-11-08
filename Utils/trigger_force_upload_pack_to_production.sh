#!/usr/bin/env bash

if [ "$#" -ne "2" ]; then
  echo "invalid command line, expected: $0 <circle token> <csv list of pack IDs>"
  exit 1
fi

_circle_token=$1
_packs=$2
_force_previous_commit=$3

trigger_build_url="https://circleci.com/api/v2/project/github/demisto/content/pipeline"

post_data=$(cat <<-EOF
{
  "branch": "master",
  "parameters": {
    "bucket_upload": "true",
    "force_pack_upload": "true",
    "packs_to_upload": "${_packs}"
    "force_previous_commit": "${_force_previous_commit}"
  }
}
EOF
)


curl \
--header "Accept: application/json" \
--header "Content-Type: application/json" \
-k \
--data "${post_data}" \
--request POST ${trigger_build_url} \
--user "$_circle_token:"
