#!/usr/bin/env python

from gi.repository import Gio, GLib

def get_proxy():
  try:
    bus = Gio.bus_get_sync(Gio.BusType.SYSTEM, None)
    proxy = Gio.DBusProxy.new_sync(bus, Gio.DBusProxyFlags.NONE, None,
                     'net.hadess.PowerProfiles',
                     '/net/hadess/PowerProfiles',
                     'org.freedesktop.DBus.Properties', None)
  except:
    raise
  return proxy


def get_power_profile(proxy):
  if proxy is None:
    proxy = get_proxy()
  return proxy.Get('(ss)', 'net.hadess.PowerProfiles', 'ActiveProfile')
  

def set_power_profile(proxy, profile):
  if proxy is None:
    proxy = get_proxy()
  try:
    proxy.Set('(ssv)',
      'net.hadess.PowerProfiles',
      'ActiveProfile',
      GLib.Variant.new_string(profile))
  except:
    raise

