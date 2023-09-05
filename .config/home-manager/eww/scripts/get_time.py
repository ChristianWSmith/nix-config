#!/usr/bin/env python

import datetime
from common import broker

def callback(_):
  return f"{datetime.datetime.now().strftime('%I:%M')}\n", None

if __name__ == "__main__":
  broker(callback)

