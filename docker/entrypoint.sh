#!/bin/bash
set -e

# Runs before every container command, so `docker compose up` is genuinely the
# only command needed on a clean checkout. Each step is a no-op once satisfied.

# Puma refuses to boot if a pid file from a hard-killed container is left behind.
rm -f tmp/pids/server.pid

# Install gems if the bundle volume is empty or the Gemfile changed.
if ! bundle check > /dev/null 2>&1; then
  echo "==> Installing gems"
  bundle install
fi

# Create any missing databases and load their schemas. With four databases
# configured (primary, cache, queue, cable) this is the step that brings all of
# them up; it also runs db/seeds.rb, but only for databases it just created.
if [ "${SKIP_DB_PREPARE:-}" != "1" ]; then
  echo "==> Preparing databases"
  bundle exec rails db:prepare
fi

exec "$@"
