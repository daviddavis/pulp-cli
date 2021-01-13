from pulpcore.cli.common.context import (
    PulpEntityContext,
    PulpRepositoryContext,
    PulpRepositoryVersionContext,
)


class PulpAnsibleContentContext(PulpEntityContext):
    ENTITY = "ansible content"
    HREF = "ansible_ansible_content_href"
    LIST_ID = "content_ansible_ansibles_list"
    READ_ID = "content_ansible_ansibles_read"
    CREATE_ID = "content_ansible_ansibles_create"


class PulpAnsibleDistributionContext(PulpEntityContext):
    ENTITY = "distribution"
    HREF = "ansible_ansible_distribution_href"
    LIST_ID = "distributions_ansible_ansible_list"
    READ_ID = "distributions_ansible_ansible_read"
    CREATE_ID = "distributions_ansible_ansible_create"
    UPDATE_ID = "distributions_ansible_ansible_update"
    DELETE_ID = "distributions_ansible_ansible_delete"


class PulpAnsibleRemoteContext(PulpEntityContext):
    ENTITY = "remote"
    HREF = "ansible_ansible_remote_href"
    LIST_ID = "remotes_ansible_ansible_list"
    CREATE_ID = "remotes_ansible_ansible_create"
    UPDATE_ID = "remotes_ansible_ansible_update"
    DELETE_ID = "remotes_ansible_ansible_delete"

class PulpAnsibleRemoteContext(PulpEntityContext):
    ENTITY = "remote"
    HREF = "ansible_ansible_remote_href"
    LIST_ID = "remotes_ansible_ansible_list"
    CREATE_ID = "remotes_ansible_ansible_create"
    UPDATE_ID = "remotes_ansible_ansible_update"
    DELETE_ID = "remotes_ansible_ansible_delete"


class PulpAnsibleRepositoryVersionContext(PulpRepositoryVersionContext):
    HREF = "ansible_ansible_repository_version_href"
    REPOSITORY_HREF = "ansible_ansible_repository_href"
    LIST_ID = "repositories_ansible_ansible_versions_list"
    READ_ID = "repositories_ansible_ansible_versions_read"
    DELETE_ID = "repositories_ansible_ansible_versions_delete"
    REPAIR_ID = "repositories_ansible_ansible_versions_repair"


class PulpAnsibleRepositoryContext(PulpRepositoryContext):
    HREF = "ansible_ansible_repository_href"
    LIST_ID = "repositories_ansible_ansible_list"
    READ_ID = "repositories_ansible_ansible_read"
    CREATE_ID = "repositories_ansible_ansible_create"
    UPDATE_ID = "repositories_ansible_ansible_update"
    DELETE_ID = "repositories_ansible_ansible_delete"
    SYNC_ID = "repositories_ansible_ansible_sync"
    MODIFY_ID = "repositories_ansible_ansible_modify"
    VERSION_CONTEXT = PulpAnsibleRepositoryVersionContext
