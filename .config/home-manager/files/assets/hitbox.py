#!/usr/bin/env python

import subprocess, os, signal, pyinotify
from threading import Thread
from queue import Queue


PATHNAME = "/dev/input/by-id/usb-DragonRise_Inc._Generic_USB_Joystick-event-joystick"
COMMAND = 'xboxdrv --evdev /dev/input/by-id/usb-DragonRise_Inc._Generic_USB_Joystick-event-joystick --evdev-keymap "BTN_TRIGGER=A,BTN_THUMB2=X,BTN_TOP=Y,BTN_THUMB=B,BTN_PINKIE=LB,BTN_TOP2=RB,BTN_BASE2=LT,BTN_BASE=RT,BTN_BASE5=TL,BTN_BASE6=TR,BTN_BASE3=Back,BTN_BASE4=Start" --evdev-absmap "ABS_X=x1,ABS_Y=y1" --axismap "-y1=y1" --mimic-xpad --silent'
CONNECT = 1
DISCONNECT = 0

run_xboxdrv = False
xboxdrv_pid = None
xboxdrv_thread = None
action_queue = Queue()


def start_xboxdrv():
    global run_xboxdrv
    global xboxdrv_pid
    while run_xboxdrv:
        xboxdrv = subprocess.Popen(COMMAND, shell=True)
        xboxdrv_pid = xboxdrv.pid
        xboxdrv.communicate()
        

def kill_until_dead():
    could_kill = True
    while could_kill:
        try:
            os.kill(xboxdrv_pid, signal.SIGKILL)
        except:
            could_kill = False


def connect():
    global run_xboxdrv
    global xboxdrv_thread
    if xboxdrv_thread is None:
        run_xboxdrv = True
        xboxdrv_thread = Thread(target=start_xboxdrv)
        xboxdrv_thread.start()


def disconnect():
    global run_xboxdrv
    global xboxdrv_thread
    if xboxdrv_thread is not None:
        run_xboxdrv = False
        kill_until_dead()
        xboxdrv_thread.join()
        xboxdrv_thread = None


def connection_broker():
    while True:
        action = action_queue.get()
        if action == CONNECT:
            connect()
        elif action == DISCONNECT:
            disconnect()


def main():
    class MyEventHandler(pyinotify.ProcessEvent):
        def process_IN_MOVED_FROM(self, event):
            if event.pathname == PATHNAME:
                action_queue.put(CONNECT)
        def process_IN_MOVED_TO(self, event):
            if event.pathname == PATHNAME:
                action_queue.put(CONNECT)
        def process_IN_CREATE(self, event):
            if event.pathname == PATHNAME:
                action_queue.put(CONNECT)
        def process_IN_DELETE(self, event):
            if event.pathname == PATHNAME:
                action_queue.put(DISCONNECT)
    wm = pyinotify.WatchManager()
    handler = MyEventHandler()
    notifier = pyinotify.Notifier(wm, handler)
    wm.add_watch('/dev/input/by-id', pyinotify.ALL_EVENTS)
    Thread(target=connection_broker).start()
    if os.path.islink(PATHNAME):
        action_queue.put(CONNECT)
    notifier.loop()


if __name__ == "__main__":
    main()

