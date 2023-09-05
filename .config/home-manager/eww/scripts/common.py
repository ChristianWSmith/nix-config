#!/usr/bin/env python

import sys, time


def broker(callback):
  _, interval = sys.argv
  interval = int(interval)

  state = None

  while True:
    message, slept, state = callback(interval, state)
    if message is not None:
      sys.stdout.write(f"{message.strip()}\n")
      sys.stdout.flush()
    if not slept:
        time.sleep(interval)
