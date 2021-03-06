#!/bin/sh

# shellcheck source=tests/scripts/config.source
. "$(dirname $(dirname "$(realpath "$0"))")/config.source"

cleanup() {
  pulp ansible remote -t "role" destroy --name "cli_test_ansible_remote" || true
  pulp ansible remote -t "collection" destroy --name "cli_test_ansible_collection_remote" || true
  pulp ansible repository destroy --name "cli_test_ansible_repository" || true
}
trap cleanup EXIT

cleanup

# Prepare
expect_succ pulp ansible remote -t "role" create --name "cli_test_ansible_remote" --url "$ANSIBLE_ROLE_REMOTE_URL"
expect_succ pulp ansible remote -t "collection" create --name "cli_test_ansible_collection_remote" \
--url "$ANSIBLE_COLLECTION_REMOTE_URL" --requirements "collections:\n  - robertdebock.ansible_development_environment"
expect_succ pulp ansible repository create --name "cli_test_ansible_repository"

# Test without remote (should fail)
expect_fail pulp ansible repository sync --name "cli_test_ansible_repository"
# Test with remote
expect_succ pulp ansible repository sync --name "cli_test_ansible_repository" --remote "cli_test_ansible_remote"

# Preconfigure remote
expect_succ pulp ansible repository update --name "cli_test_ansible_repository" --remote "cli_test_ansible_remote"

# Test with remote
expect_succ pulp ansible repository sync --name "cli_test_ansible_repository"
# Test without remote
expect_succ pulp ansible repository sync --name "cli_test_ansible_repository" --remote "cli_test_ansible_remote"

# Verify sync
expect_succ pulp ansible repository version --repository "cli_test_ansible_repository" list
test "$(echo "$OUTPUT" | jq -r length)" -eq 2
expect_succ pulp ansible repository version --repository "cli_test_ansible_repository" show --version 1
test "$(echo "$OUTPUT" | jq -r '.content_summary.present."ansible.role".count')" -eq 56

# Test repair the version
expect_succ pulp ansible repository version --repository "cli_test_ansible_repository" repair --version 1
test "$(echo "$OUTPUT" | jq -r '.state')" = "completed"

# Delete version again
expect_succ pulp ansible repository version --repository "cli_test_ansible_repository" destroy --version 1

# Test with collection remote
expect_succ pulp ansible repository sync --name "cli_test_ansible_repository" --remote "cli_test_ansible_collection_remote"

# Verify sync
expect_succ pulp ansible repository version --repository "cli_test_ansible_repository" list
test "$(echo "$OUTPUT" | jq -r length)" -eq 2
expect_succ pulp ansible repository version --repository "cli_test_ansible_repository" show --version 2
test "$(echo "$OUTPUT" | jq -r '.content_summary.present."ansible.collection_version".count')" -eq 3

