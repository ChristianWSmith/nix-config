#!/usr/bin/env python

import psutil, sys, os, time


def broker(callback):
  _, file_path, interval = sys.argv
  interval = int(interval)

  buffer_file_path=f"{file_path}.buffer"

  state = None

  while True:
    file = open(buffer_file_path, "w")
    message, slept, state = callback(interval, state)
    if message is not None:
      file.write(message)
    if not slept:
        time.sleep(interval)
    file.close()
    os.rename(buffer_file_path, file_path)
