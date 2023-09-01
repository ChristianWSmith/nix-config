#!/usr/bin/env python

import psutil, sys, os, time


def broker(callback):
  _, file_path, interval = sys.argv
  interval = int(interval)

  buffer_file_path=f"{file_path}.buffer"

  state = None

  while True:
    message, slept, state = callback(interval, state)
    if message is not None:
      file = open(buffer_file_path, "w")
      file.write(f"{message.strip()}\n")
      file.close()
      os.rename(buffer_file_path, file_path)
    if not slept:
        time.sleep(interval)
