#file-name: discord_notify.sh
#!/bin/bash

COMMIT_TIME=$(git show -s --format=%ct $CI_COMMIT_SHA)
COMMIT_TIME_STR=$(date -d @$COMMIT_TIME +"%H:%M:%S %d/%m/%Y")

current_time=$(date +"%Y-%m-%dT%H:%M:%S%:z")
current_timestamp=$(date +"%Y-%m-%dT%H:%M:%S")

difference=$(( $(date -d "$current_time" "+%s") - $COMMIT_TIME ))
commit_timestamp=$(date -d @$COMMIT_TIME +"%Y-%m-%dT%H:%M:%S")

echo "COMMIT_TIME_STR: $COMMIT_TIME_STR"
echo "current_time: $current_time"
echo "current_timestamp: $current_timestamp"
echo "difference: $difference"
echo "commit_timestamp: $commit_timestamp"
echo "Commit message: $CI_COMMIT_MESSAGE"
echo "Job: $CI_JOB_NAME with status: $CI_JOB_STATUS"

function duration_time {
    local T=$1
    local D=$((T/60/60/24))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))
    (( $D > 0 )) && printf '%d days ' $D
    (( $H > 0 )) && printf '%d hours ' $H
    (( $M > 0 )) && printf '%d minutes ' $M
    (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
    printf '%d seconds\n' $S
}

generate_post_data() {
if [[ -z "$CI_JOB_NAME" || "$CI_JOB_NAME" == "notify_discord" ]] ; then
color=1458915
cat <<EOF
{
"embeds": [{
    "title": "$($CI_COMMIT_MESSAGE | xargs)",
    "url": "$COMMIT_URL",
    "color": $color,
    "timestamp": "$current_timestamp",
    "fields": [{
            "name": "Repo",
            "value": "[$CI_PROJECT_NAME]($CI_PROJECT_URL)",
            "inline": true
        },
        {
            "name": "Branch",
            "value": "[$CI_COMMIT_BRANCH]($CI_PROJECT_URL/tree/$CI_COMMIT_BRANCH)",
            "inline": true
        },
        {
            "name": "Hash",
            "value": "[$CI_COMMIT_SHA]($COMMIT_URL)"
        },
        {
            "name": "Job name",
            "value": "[$CI_JOB_NAME]($CI_JOB_URL)"
        },
        {
            "name": "Duration",
            "value": "$(duration_time $difference)",
            "inline": true
        },
        {
            "name": "Created at",
            "value": "$COMMIT_TIME_STR"
        }
    ],
    "author": {
        "name": "$GITLAB_USER_NAME",
        "url": "$CI_SERVER_URL/$GITLAB_USER_LOGIN"
    }
}]}
EOF
elif [[ "$CI_JOB_STATUS" == "success" ]] ; then
color=2086256
cat <<EOF
{
"embeds": [{
    "title": "Artifact was created",
    "color": $color,
    "timestamp": "$current_timestamp",
    "fields": [{
            "name": "Repo",
            "value": "[$CI_PROJECT_NAME]($CI_PROJECT_URL)",
            "inline": true
        },
        {
            "name": "Branch",
            "value": "[$CI_COMMIT_BRANCH]($CI_PROJECT_URL/tree/$CI_COMMIT_BRANCH)",
            "inline": true
        },
        {
            "name": "Hash",
            "value": "[$CI_COMMIT_SHA]($COMMIT_URL)"
        },
        {
            "name": "Job name",
            "value": "[$CI_JOB_NAME]($CI_JOB_URL)"
        },
        {
            "name": "Duration",
            "value": "$(duration_time $difference)",
            "inline": true
        },
        {
            "name": "Created at",
            "value": "$COMMIT_TIME_STR"
        }
    ],
    "author": {
        "name": "$GITLAB_USER_NAME",
        "url": "$CI_SERVER_URL/$GITLAB_USER_LOGIN"
    }
}]}
EOF
else
color=14227074
cat <<EOF
{
"embeds": [{
    "title": "Job faile",
    "url": "$COMMIT_URL",
    "color": $color,
    "timestamp": "$current_timestamp",
    "fields": [{
            "name": "Repo",
            "value": "[$CI_PROJECT_NAME]($CI_PROJECT_URL)",
            "inline": true
        },
        {
            "name": "Branch",
            "value": "[$CI_COMMIT_BRANCH]($CI_PROJECT_URL/tree/$CI_COMMIT_BRANCH)",
            "inline": true
        },
        {
            "name": "Hash",
            "value": "[$CI_COMMIT_SHA]($COMMIT_URL)"
        },
        {
            "name": "Job name",
            "value": "[$CI_JOB_NAME]($CI_JOB_URL)"
        },
        {
            "name": "Duration",
            "value": "$(duration_time $difference)",
            "inline": true
        },
        {
            "name": "Created at",
            "value": "$COMMIT_TIME_STR"
        }
    ],
    "author": {
        "name": "$GITLAB_USER_NAME",
        "url": "$CI_SERVER_URL/$GITLAB_USER_LOGIN"
    }
}]}
EOF
fi
}

data=$(generate_post_data)

if [[ -z "$DISCORD_WEBHOOK_TEST" ]] ; then
    curl --location --request POST "$DISCORD_WEBHOOK_TEST" \
    --header 'Content-Type: application/json' \
    --data "$data"
fi

curl --location --request POST "$DISCORD_WEBHOOK" \
--header 'Content-Type: application/json' \
--data "$data"
