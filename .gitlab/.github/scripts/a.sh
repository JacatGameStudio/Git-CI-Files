generate_post_data() {
if [[ -z "$job_name" ]] ; then
color=1458915
cat <<EOF
{
"embeds": [{
    "title": "New commit to $REPO_NAME",
    "url": "$COMMIT_URL",
    "color": $color,
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
            "name": "Duration",
            "value": "$(duration_time $difference)",
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
}]}
EOF

elif [[ "$job_status" -ne "success" ]] ; then
color=14227074
cat <<EOF
{
"embeds": [{
    "title": "Job faile",
    "url": "$COMMIT_URL",
    "color": $color,
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
        "icon_url": "https://cdn-cms.jacatgames.com/output-onlinepngtools-removebg-preview.png"
    }
}]}
EOF
}