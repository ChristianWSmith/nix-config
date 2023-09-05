#!/usr/bin/env python

import psutil, subprocess
from common import broker

PATH_RECORDING = subprocess.check_output(['get-icon', 'media-record']).decode('utf-8')
PATH_NOT_RECORDING = subprocess.check_output(['get-icon', 'screen-recorder']).decode('utf-8')

PATH_KEY = "path"

def callback(interval, state):
  message = None
  if state is None:
      state = {PATH_KEY: None}

  new_path = PATH_NOT_RECORDING
  for process in psutil.process_iter():
    if process.name() == "wf-recorder":
      new_path = PATH_RECORDING
      break

  if new_path != state[PATH_KEY]:
    message = new_path
    state[PATH_KEY] = new_path

  return message, False, state

if __name__ == "__main__":
  broker(callback)

