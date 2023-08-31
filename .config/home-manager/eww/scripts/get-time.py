#!/usr/bin/env python

import datetime, time
from common import broker

def callback(interval):
  time.sleep(interval)
  return f"{datetime.datetime.now().strftime('%I:%M')}\n" 

broker(callback)

