#!/usr/bin/env bash
# Install the ai-config plugin in Claude Code cloud sessions.
# settings.json declares the Morrison-Lab marketplace and enables
# ai-config@Morrison-Lab, but a declared plugin from an external source
# doesn't load until it is installed, and fresh cloud containers never
# install it.
# Local sessions install it once by hand, so this hook runs only remotely.
set -uo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if claude plugin list 2>/dev/null | grep -q 'ai-config@Morrison-Lab'; then
  exit 0
fi

claude plugin marketplace add Morrison-Lab/ai-config >/dev/null 2>&1 ||
  claude plugin marketplace update Morrison-Lab >/dev/null 2>&1 || true
claude plugin install ai-config@Morrison-Lab >/dev/null 2>&1 ||
  echo "install-ai-config: could not install ai-config@Morrison-Lab" >&2
exit 0
