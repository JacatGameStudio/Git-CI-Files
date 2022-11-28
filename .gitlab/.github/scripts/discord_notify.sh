#file-name: discord_notify.sh
#!/bin/bash

job_name=$1
job_status=$2
file_name=$3
file_size=$4
file_url=$5

current_time=$(date +"%Y-%m-%dT%H:%M:%S%:z")
current_timestamp=$(date +"%Y-%m-%dT%H:%M:%S")
difference=$(( $(date -d "$current_time" "+%s") - $(date -d "$COMMIT_TIME" "+%s") ))
commit_timestamp=$(date --date=$COMMIT_TIME +"%Y-%m-%dT%H:%M:%S")

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
if [[ -z "$job_name" ]] ; then
color=1458915
cat <<EOF
{
    "embeds": [{
        "title": "$COMMIT_MESSAGE",
        "url": "$COMMIT_URL",
        "color": $color,
        "timestamp": "$commit_timestamp",
        "fields": [{
                "name": "Repo",
                "value": "[$REPO_NAME]($REPO_URL)",
                "inline": true
            },
            {
                "name": "Branch",
                "value": "[$BRANCH_NAME]($REPO_URL/tree/$BRANCH_NAME)",
                "inline": true
            },
            {
                "name": "Hash",
                "value": "[$COMMIT_HASH]($COMMIT_COMPARE)"
            },
            {
                "name": "Created at",
                "value": "$COMMIT_TIME"
            }
        ],
        "thumbnail": {
            "url": "$ORG_AVATAR"
        },
        "author": {
            "name": "$COMMIT_USER",
            "url": "$USER_URL",
            "icon_url": "$USER_AVATAR"
        }
    }]
}
EOF
elif [[ "$job_status" -ne "success" ]] ; then
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
            "value": "[$REPO_NAME]($REPO_URL)",
            "inline": true
        },
        {
            "name": "Branch",
            "value": "[$BRANCH_NAME]($REPO_URL/tree/$BRANCH_NAME)",
            "inline": true
        },
        {
            "name": "Hash",
            "value": "[$COMMIT_HASH]($COMMIT_COMPARE)"
        },
        {
            "name": "Job name",
            "value": "$job_name"
        },
        {
            "name": "Duration",
            "value": "$(duration_time $difference)",
            "inline": true
        },
        {
            "name": "Created at",
            "value": "$COMMIT_TIME"
        }
    ],
    "thumbnail": {
        "url": "$ORG_AVATAR"
    },
    "author": {
        "name": "$COMMIT_USER",
        "url": "$USER_URL",
        "icon_url": "$USER_AVATAR"
    }
}]}
EOF
else
color=2086256
cat <<EOF
{
"embeds": [{
    "title": "Artifact was created",
    "url": "$file_url",
    "color": $color,
    "timestamp": "$current_timestamp",
    "fields": [{
            "name": "Repo",
            "value": "[$REPO_NAME]($REPO_URL)",
            "inline": true
        },
        {
            "name": "Branch",
            "value": "[$BRANCH_NAME]($REPO_URL/tree/$BRANCH_NAME)",
            "inline": true
        },
        {
            "name": "Hash",
            "value": "[$COMMIT_HASH]($COMMIT_URL)"
        },
        {
            "name": "Job name",
            "value": "$job_name"
        },
        {
            "name": "Duration",
            "value": "$(duration_time $difference)",
            "inline": true
        },
        {
            "name": "Created at",
            "value": "$COMMIT_TIME"
        }
    ],
    "thumbnail": {
        "url": "$ORG_AVATAR"
    },
    "author": {
        "name": "$COMMIT_USER",
        "url": "$USER_URL",
        "icon_url": "$USER_AVATAR"
    },
    
    "footer": {
        "text": "$file_name | $file_size",
        "icon_url": "https://cdn-cms.jacatgames.com/attach-2-32.ico"
    }
}]}
EOF
fi
}

curl --location --request POST "$DISCORD_WEBHOOK" \
--header 'Content-Type: application/json' \
--data "$(generate_post_data)"