#!/usr/bin/env python

import datetime
from common import broker

def callback(interval, _):
  return f"{datetime.datetime.now().strftime('%a %b %d %I:%M:%S %p %Y')}\n", False, None

broker(callback)

