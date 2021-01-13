#!/bin/sh

# shellcheck source=tests/scripts/config.source
. "$(dirname "$(realpath "$0")")/config.source"

require_min_pulp "3.10.0"

cleanup() {
  pulp file repository destroy --name "cli_test_file_repo" || true
}
trap cleanup EXIT

name="cli_test_file_repo"
expect_succ pulp file repository create --name "$name"
expect_succ pulp file repository label set --name "$name" --key "atani" --value "hurin"
expect_succ pulp file repository label set --name "$name" --key "ainur" --value "ulmo"

expect_succ pulp file repository show --name "$name"
test "$(echo "$OUTPUT" | jq -r -c .pulp_labels)" = '{"atani":"hurin","ainur":"ulmo"}'

# update a label
expect_succ pulp file repository label set --name "$name" --key "atani" --value "beor"
expect_succ pulp file repository show --name "$name"
test "$(echo "$OUTPUT" | jq -r -c .pulp_labels)" = '{"ainur":"ulmo","atani":"beor"}'

# remove a label
expect_succ pulp file repository label unset --name "$name" --key "atani"
expect_succ pulp file repository show --name "$name"
test "$(echo "$OUTPUT" | jq -r -c .pulp_labels)" = '{"ainur":"ulmo"}'

# filtering
expect_succ pulp file repository list --label-select "ainur"
test "$(echo "$OUTPUT" | jq length)" -eq 1
expect_succ pulp file repository list --label-select "!ainur"
test "$(echo "$OUTPUT" | jq length)" -eq 0
expect_succ pulp file repository list --label-select "ainur=ulmo"
test "$(echo "$OUTPUT" | jq length)" -eq 1
expect_succ pulp file repository list --label-select "ainur!=ulmo"
test "$(echo "$OUTPUT" | jq length)" -eq 0
expect_succ pulp file repository list --label-select "ainur~lm"
test "$(echo "$OUTPUT" | jq length)" -eq 1

expect_succ pulp file repository label set --name "$name" --key "istar" --value "olorin"
expect_succ pulp file repository list --label-select "ainur=ulmo,istar!=curumo"
test "$(echo "$OUTPUT" | jq length)" -eq 1
expect_succ pulp file repository list --label-select "ainur=ulmo,istar=olorin"
test "$(echo "$OUTPUT" | jq length)" -eq 1
