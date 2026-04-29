#!/usr/bin/env bash
set -euo pipefail

xcodebuild \
  -project GlassHub.xcodeproj \
  -scheme GlassHub \
  -destination 'platform=macOS' \
  build
