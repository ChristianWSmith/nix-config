#!/usr/bin/env python

import datetime
from common import broker

def callback(_):
  return f"{datetime.datetime.now().strftime('%a %b %d %I:%M:%S %p %Y')}\n", None

if __name__ == "__main__":
  broker(callback)

