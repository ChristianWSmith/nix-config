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


def _get():
    proxy = get_proxy()
    profile = proxy.Get('(ss)', 'net.hadess.PowerProfiles', 'ActiveProfile')
    print(profile)


def _set(profile):
    try:
        proxy = get_proxy()
        proxy.Set('(ssv)',
            'net.hadess.PowerProfiles',
            'ActiveProfile',
            GLib.Variant.new_string(profile))
    except:
        raise

_get()

