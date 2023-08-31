#!/usr/bin/env python

import psutil, sys, os


def broker(callback):
  _, file_path, interval = sys.argv
  interval = int(interval)

  buffer_file_path=f"{file_path}.buffer"

  while True:
    file = open(buffer_file_path, "w")
    file.write(callback(interval))
    file.close()
    os.rename(buffer_file_path, file_path)
