#!/usr/bin/env python

import datetime, time
from common import broker

def callback(interval):
  time.sleep(interval)
  return f"{datetime.datetime.now().strftime('%a %b %d %I:%M:%S %p %Y')}\n" 

broker(callback)

