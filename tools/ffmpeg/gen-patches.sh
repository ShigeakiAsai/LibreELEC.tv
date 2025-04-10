#!/bin/bash

# base ffmpeg version
FFMPEG_REPO="git://source.ffmpeg.org/ffmpeg.git"
FFMPEG_VERSION="n7.1.1"

ALL_FEATURE_SETS="v4l2-drmprime v4l2-request libreelec rpi vf-deinterlace-v4l2m2m"

if [ $# -eq 0 ]; then
  echo "usage: $0 all|featureset [githash]"
  echo "available feature sets: ${ALL_FEATURE_SETS}"
  exit 1
fi

FFMPEG_ROOT="$(pwd)"
LE_ROOT="$(
  cd $(dirname $0)/../..
  pwd
)"

create_patch() {
  FEATURE_SET="$1"
  REFTYPE="branch"

  BASE_REPO="${FFMPEG_REPO}"
  BASE_VERSION="${FFMPEG_VERSION}"

  PATCH_CREATE_DIFF="no"

  case "${FEATURE_SET}" in
    v4l2-drmprime | v4l2-request | vf-deinterlace-v4l2m2m)
      REPO="https://github.com/jernejsk/FFmpeg"
      REFSPEC="${FEATURE_SET}-${FFMPEG_VERSION}"
      ;;
    libreelec)
      REPO="https://github.com/LibreELEC/FFmpeg"
      REFSPEC="libreelec-misc-${FFMPEG_VERSION}"
      ;;
    rpi)
      REPO="https://github.com/jc-kynesim/rpi-ffmpeg"
      REFSPEC="dev/7.1.1/rpi_import_1"
      PATCH_CREATE_DIFF="yes"
      ;;
    *)
      echo "illegal feature set ${FEATURE_SET}"
      exit 1
      ;;
  esac

  # get base ffmpeg version
  git fetch "${BASE_REPO}" "${BASE_VERSION}"
  BASE_REV=$(git rev-parse FETCH_HEAD)

  PATCH_DIR="packages/multimedia/ffmpeg/patches/${FEATURE_SET}"
  PATCH_FILE="${PATCH_DIR}/ffmpeg-001-${FEATURE_SET}.patch"
  mkdir -p "${LE_ROOT}/${PATCH_DIR}"

  git fetch "${REPO}" "${REFSPEC}"
  if [ $# -ge 2 ]; then
    REV="$2"
  else
    REV=$(git rev-parse FETCH_HEAD)
  fi
  BASE_REV=$(git merge-base "${BASE_REV}" "${REV}")

  if [ -f "${LE_ROOT}/${PATCH_FILE}" ]; then
    ACTION="update"
  else
    ACTION="create"
  fi

  if [ "${PATCH_CREATE_DIFF}" = "yes" ]; then
    # create diff in case format-patch doesn't work, eg when we have non-linear history
    git diff "${BASE_REV}..${REV}" >"${LE_ROOT}/${PATCH_FILE}"
  else
    git format-patch --stdout --no-signature "${BASE_REV}..${REV}" >"${LE_ROOT}/${PATCH_FILE}"
  fi

  MSG=$(mktemp)

  cat <<EOF >"${MSG}"
ffmpeg: ${ACTION} ${FEATURE_SET} patch

Patch created using revisions ${BASE_REV:0:7}..${REV:0:7}
from ${REFTYPE} ${REFSPEC} of ${REPO}
EOF

  cd "${LE_ROOT}"
  git add "${PATCH_FILE}"
  git commit -F "${MSG}" ${GIT_COMMIT_ARGS}
  cd "${FFMPEG_ROOT}"
  rm "${MSG}"
}

if [ "$1" = "all" ]; then
  for SET in ${ALL_FEATURE_SETS}; do
    create_patch "${SET}"
  done
else
  create_patch "$@"
fi
