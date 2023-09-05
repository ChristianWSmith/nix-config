#!/usr/bin/env python

import datetime
from common import broker

def callback(interval, _):
  return f"{datetime.datetime.now().strftime('%I:%M')}\n", False, None

if __name__ == "__main__":
  broker(callback)

