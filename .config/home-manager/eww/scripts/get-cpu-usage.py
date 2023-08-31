#!/usr/bin/env python

import psutil
from common import broker

def callback(interval):
  return f"{psutil.cpu_percent(interval)}%\n" 

broker(callback)

