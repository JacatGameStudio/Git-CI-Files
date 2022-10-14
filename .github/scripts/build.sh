#!/usr/bin/env bash

set -e
set -x

echo "Building for $BUILD_TARGET"

export BUILD_PATH=~/Workspace/Builds/$BUILD_TARGET/$GITHUB_RUN_ID
mkdir -p $BUILD_PATH

${UNITY_EXECUTABLE:-xvfb-run --auto-servernum --server-args='-screen 0 640x480x24' unity-editor} \
  -projectPath $UNITY_DIR \
  -quit \
  -batchmode \
  -nographics \
  -buildTarget $BUILD_TARGET \
  -customBuildTarget $BUILD_TARGET \
  -customBuildName $BUILD_NAME \
  -customBuildPath $BUILD_PATH \
  -executeMethod BuildCommand.PerformBuild \
  # -logFile $BUILD_PATH/log.log
  # -logFile /dev/stdout

echo "Build done"
ls -la $BUILD_PATH
