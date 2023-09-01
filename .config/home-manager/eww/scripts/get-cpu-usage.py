#!/usr/bin/env python

import psutil
from common import broker

def callback(interval, _):
  return f"{int(psutil.cpu_percent(interval))}%\n", True, None

broker(callback)

