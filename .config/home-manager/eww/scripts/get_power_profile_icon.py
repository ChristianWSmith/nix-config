#!/usr/bin/env python

import psutil, subprocess
from common import broker
from common_power_profile import get_power_profile, get_proxy


PATH_POWER_SAVER = subprocess.check_output(['get-icon', 'power-profile-power-saver-symbolic']).decode('utf-8')
PATH_BALANCED = subprocess.check_output(['get-icon', 'power-profile-balanced-symbolic']).decode('utf-8')
PATH_PERFORMANCE = subprocess.check_output(['get-icon', 'power-profile-performance-symbolic']).decode('utf-8')
PATH_ERROR = subprocess.check_output(['get-icon', 'system-error']).decode('utf-8')

PROXY_KEY="proxy"
PROFILE_KEY="profile"
PATH_KEY="path"

PATH_MAP = {
  "power-saver": PATH_POWER_SAVER,
  "balanced": PATH_BALANCED,
  "performance": PATH_PERFORMANCE
}

def callback(interval, state):
  message = None
  if state is None:
    state = {PROXY_KEY: get_proxy(), PROFILE_KEY: "", PATH_KEY: ""}
  profile = get_power_profile(state[PROXY_KEY])

  if profile in PATH_MAP:
    new_path = PATH_MAP[profile]
  else:
    new_path = PATH_ERROR

  if new_path != state[PATH_KEY]:
    message = new_path
    state[PATH_KEY] = new_path

  return message, False, state

if __name__ == "__main__":
  broker(callback)

