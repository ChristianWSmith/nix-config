#!/usr/bin/env python

import psutil
from common import broker
from threading import Thread
from queue import Queue


_current_cpu_usage = -1
STARTED_KEY = "started"

def poller():
  global _current_cpu_usage
  while True:
    _current_cpu_usage = psutil.cpu_percent(interval=1)


def callback(state):
  global _current_cpu_usage
  if state is None or state[STARTED_KEY] != True:
    Thread(target=poller).start()
    state = { STARTED_KEY: True }
  return f"{int(_current_cpu_usage)}%\n", state


if __name__ == "__main__":
  broker(callback)

