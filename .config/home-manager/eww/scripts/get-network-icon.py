#!/usr/bin/env python

import psutil, subprocess, socket
from common import broker

PATH_ERROR = subprocess.check_output(['get-icon', 'network-error']).decode('utf-8')
PATH_IDLE = subprocess.check_output(['get-icon', 'network-idle']).decode('utf-8')
PATH_DISCONNECTED = subprocess.check_output(['get-icon', 'network-offline']).decode('utf-8')
PATH_RECEIVE = subprocess.check_output(['get-icon', 'network-receive']).decode('utf-8')
PATH_TRANSMIT = subprocess.check_output(['get-icon', 'network-transmit']).decode('utf-8')
PATH_TRANSMIT_RECEIVE = subprocess.check_output(['get-icon', 'network-transmit-receive']).decode('utf-8')

SENT_KEY = "sent"
RECV_KEY = "recv"
PATH_KEY = "path"

def active_interface():
  for interface_addrs in psutil.net_if_addrs().values():
    if socket.AF_INET in [snicaddr.family for snicaddr in interface_addrs]:
      return True
  return False


def callback(interval, state):
  message = None
  if state is None:
    state = {SENT_KEY: 0, RECV_KEY: 0, PATH_KEY: ""}
  if active_interface():
    io = psutil.net_io_counters()
    delta_sent = io.bytes_sent - state[SENT_KEY]
    delta_recv = io.bytes_recv - state[RECV_KEY]
    state[SENT_KEY] = io.bytes_sent
    state[RECV_KEY] = io.bytes_recv
    if delta_sent == 0:
      if delta_recv == 0:
        new_path = PATH_IDLE
      else:
        new_path = PATH_RECEIVE
    else:
      if delta_recv == 0:
        new_path = PATH_TRANSMIT
      else:
        new_path = PATH_TRANSMIT_RECEIVE
  else:
      new_path = PATH_DISCONNECTED

  if new_path != state[PATH_KEY]:
    state[PATH_KEY] = new_path
    message = new_path

  return message, False, state

broker(callback)

