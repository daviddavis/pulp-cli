import click

from pulpcore.cli.common.generic import (
    list_entities,
    show_by_name,
    destroy_by_name,
)
from pulpcore.cli.common.context import (
    PulpContext,
    pass_pulp_context,
    pass_entity_context,
)
# from pulpcore.cli.ansible.context import PulpAnsibleCollectionRemoteContext, PulpAnsibleRoleRemoteContext


# @click.group()
# @click.option(
    # "-t",
    # "--type",
    # "remote_type",
    # type=click.Choice(["collection", "role"], case_sensitive=False),
    # default="ansible",
# )
# @pass_pulp_context
# @click.pass_context
# def remote(ctx: click.Context, pulp_ctx: PulpContext, remote_type: str) -> None:
    # if remote_type == "collection":
        # ctx.obj = PulpAnsibleCollectionRemoteContext(pulp_ctx)
    # if remote_type == "role":
        # ctx.obj = PulpAnsibleRoleRemoteContext(pulp_ctx)
    # else:
        # raise NotImplementedError()


# remote.add_command(list_entities)
# remote.add_command(show_by_name)


# @remote.command()
# @click.option("--name", required=True)
# @click.option("--url", required=True)
# @pass_entity_context
# @pass_pulp_context
# def create(pulp_ctx: PulpContext, remote_ctx: PulpEntityContext, name: str, url: str) -> None:
    # remote = {"name": name, "url": url}
    # result = remote_ctx.create(body=remote)
    # pulp_ctx.output_result(result)


# remote.add_command(destroy_by_name)
