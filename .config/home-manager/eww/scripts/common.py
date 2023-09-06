#!/usr/bin/env python

from sys import argv, stdout
from time import time, sleep

def broker(callback):
  _, interval = argv
  interval = int(interval)

  state = None

  next_time = time() + interval
  while True:
    message, state = callback(state)
    if message is not None:
      stdout.write(f"{message.strip()}\n")
      stdout.flush()
    duration = next_time - time()
    if duration > 0:
      sleep(duration)
      next_time += interval
    else:
      next_time = time() + interval


