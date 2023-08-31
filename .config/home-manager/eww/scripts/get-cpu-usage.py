#!/usr/bin/env python

from common import broker

def callback():
  return f"{psutil.cpu_percent(interval)}%\n" 

broker(callback)

