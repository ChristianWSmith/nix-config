#!/usr/bin/env python

import psutil, sys, os

_, file_path, interval = sys.argv
interval = int(interval)

while True:
  os.remove(file_path)
  file = open(file_path, "a")
  file.write(f"{psutil.cpu_percent(interval)}%\n")
  file.close()
