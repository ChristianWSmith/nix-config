#!/usr/bin/env python

import psutil
from common import broker
from common_power_profile import get_power_profile, get_proxy


PROXY_KEY="proxy"
PROFILE_KEY="profile"


def callback(interval, state):
  message = None
  if state is None:
    state = {PROXY_KEY: get_proxy(), PROFILE_KEY: ""}
  profile = get_power_profile(state[PROXY_KEY])
  if profile != state[PROFILE_KEY]:
    message = profile
    state[PROFILE_KEY] = profile
  return message, False, state

if __name__ == "__main__":
  broker(callback)

