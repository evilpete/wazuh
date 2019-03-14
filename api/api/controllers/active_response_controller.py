
# Copyright (C) 2015-2019, Wazuh Inc.
# Created by Wazuh, Inc. <info@wazuh.com>.
# This program is a free software; you can redistribute it and/or modify it under the terms of GPLv2

import asyncio
import connexion
import logging

import wazuh.active_response as active_response
from wazuh.cluster.dapi.dapi import DistributedAPI
from ..util import remove_nones_to_dict

loop = asyncio.get_event_loop()
logger = logging.getLogger('wazuh.active_response_controller')


def run_command(pretty=False, wait_for_complete=False):
    """
    Runs an Active Response command on a specified agent

    :param pretty: Show results in human-readable format
    :type pretty: bool
    :param wait_for_complete: Disable timeout response
    :type wait_for_complete: bool
    :param agent_id: Agent ID. All posible values since 000 onwards
    :type agent_id: str
    :param command: Command running in the agent. If this value starts by !, then it refers to a script name instead of a command name
    :type command: str
    :param custom: Whether the specified command is a custom command or not
    :type custom: bool
    :param arguments: Command arguments
    :type arguments: str

    :rtype: dict
    """

    # get body parameters
    if connexion.request.is_json:
        body = connexion.request.get_json()

    f_kwargs = {'agent_id': agent_id, 'command': command, 'custom': custom,
                'arguments': arguments
               }

    dapi = DistributedAPI(f=active_response.run_command,
                          f_kwargs=remove_nones_to_dict(f_kwargs),
                          request_type='distributed_master',
                          is_async=False,
                          wait_for_complete=wait_for_complete,
                          pretty=pretty,
                          logger=logger
                          )

    data = loop.run_until_complete(dapi.distribute_function())

    return data, 200