#!/bin/sh

# shellcheck source=tests/scripts/config.source
. "$(dirname $(dirname "$(realpath "$0"))")/config.source"

cleanup() {
  pulp file repository destroy --name "cli_test_file_repo" || true
}
trap cleanup EXIT

expect_succ pulp file repository list

expect_succ pulp file repository create --name "cli_test_file_repo" --description "Test repository for CLI tests"
expect_succ pulp file repository update --name "cli_test_file_repo" --description ""
expect_succ pulp file repository show --name "cli_test_file_repo"
test "$(echo "$OUTPUT" | jq -r '.description')" = "null"
expect_succ pulp file repository list
expect_succ pulp file repository destroy --name "cli_test_file_repo"
