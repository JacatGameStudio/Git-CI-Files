#!/bin/bash

set -e
set -x
whoami
mkdir -p ~/.cache/unity3d
mkdir -p ~/.local/share/unity3d/Unity/
set +x

unity_license_destination=~/.local/share/unity3d/Unity/Unity_lic.ulf
android_keystore_destination=keystore.keystore

if [ "$BUILD_TARGET" = "Android" ]
then
    if [ -n "$ANDROID_KEYSTORE_BASE64" ]
    then
        echo "'\$ANDROID_KEYSTORE_BASE64' found, decoding content into ${android_keystore_destination}"
        echo $ANDROID_KEYSTORE_BASE64 | base64 --decode > ${android_keystore_destination}
    else
        echo '$ANDROID_KEYSTORE_BASE64'" env var not found, building with Unity's default debug keystore"
    fi
fi

if [ -n "$UNITY_LICENSE" ]
then
    echo "Writing '\$UNITY_LICENSE' to license file ${unity_license_destination}"
    echo "${UNITY_LICENSE}" | tr -d '\r' > ${unity_license_destination}
else
    echo "'\$UNITY_LICENSE' env var not found"
fi
