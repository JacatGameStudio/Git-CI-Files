#!/bin/bash

export DISCORD_WEBHOOK_TEST="https://discordapp.com/api/webhooks/1024600293666730015/gCq71FoQpI_YNtVhw-rDGg29Z32SoiPfpvXbCE5FgqoYQs3ouovqTQ_t7YK_hdkWqaY9"
export DISCORD_WEBHOOK="https://discordapp.com/api/webhooks/1024600293666730015/gCq71FoQpI_YNtVhw-rDGg29Z32SoiPfpvXbCE5FgqoYQs3ouovqTQ_t7YK_hdkWqaY9"
export CI_COMMIT_SHA="e7548d8738d51c61430d78731174b0d80744ab53"
export CI_JOB_NAME="notify_discord"
export CI_COMMIT_MESSAGE="COMMIT_TIME and WEBHOOK_TEST"
export COMMIT_URL="https://gitlab.volio.vn/jacatgames/ChibiDollMaker/-/commit/32314835274f09061e3fe8715dede93b4367c937"
export CI_PROJECT_NAME="ChibiDollMaker"
export CI_PROJECT_URL="https://gitlab.volio.vn/jacatgames/ChibiDollMaker"
export CI_COMMIT_BRANCH="features/ci"
export CI_COMMIT_SHA="32314835274f09061e3fe8715dede93b4367c937"
export GITLAB_USER_NAME="Kim Ericko"
export CI_SERVER_URL="https://gitlab.volio.vn/"
export GITLAB_USER_LOGIN="kimpv"

./discord_notify.sh

# export BUILD_TARGET="Android"
# export ANDROID_KEYSTORE_BASE64 = "Y29udGVudA=="

# ./before_script.sh