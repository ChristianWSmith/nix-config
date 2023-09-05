#!/usr/bin/env python
from common import broker
from get_cpu_usage import callback as cpu_usage_callback
from get_date import callback as date_callback
from get_network_icon import callback as network_icon_callback
from get_power_profile_icon import callback as power_profile_icon_callback
from get_power_profile import callback as power_profile_callback
from get_screen_recorder_icon import callback as screen_recorder_icon_callback
from get_time import callback as time_callback
import json

CPU_USAGE_KEY = "cpu_usage"
DATE_KEY = "date"
NETWORK_ICON_KEY = "network_icon"
POWER_PROFILE_ICON_KEY = "power_profile_icon"
POWER_PROFILE_KEY = "power_profile"
SCREEN_RECORDER_ICON_KEY = "screen_recorder_icon"
TIME_KEY = "time"


def subcall(state, message_map, subcallback, key):
  submessage, substate = subcallback(state[key])
  state[key] = substate
  if submessage is not None:
    message_map[key] = f"{submessage.strip()}"
  return message_map, state


def callback(state):
  if state is None:
    state = {
      CPU_USAGE_KEY: None,
      DATE_KEY: None,
      NETWORK_ICON_KEY: None,
      POWER_PROFILE_ICON_KEY: None,
      POWER_PROFILE_KEY: None,
      SCREEN_RECORDER_ICON_KEY: None,
      TIME_KEY: None
    }
  message_map = {}
  message_map, state = subcall(state, message_map, cpu_usage_callback, CPU_USAGE_KEY)
  message_map, state = subcall(state, message_map, date_callback, DATE_KEY)
  message_map, state = subcall(state, message_map, network_icon_callback, NETWORK_ICON_KEY)
  message_map, state = subcall(state, message_map, power_profile_icon_callback, POWER_PROFILE_ICON_KEY)
  message_map, state = subcall(state, message_map, power_profile_callback, POWER_PROFILE_KEY)
  message_map, state = subcall(state, message_map, screen_recorder_icon_callback, SCREEN_RECORDER_ICON_KEY)
  message_map, state = subcall(state, message_map, time_callback, TIME_KEY)

  return json.dumps(message_map), state


if __name__ == "__main__":
  broker(callback)

