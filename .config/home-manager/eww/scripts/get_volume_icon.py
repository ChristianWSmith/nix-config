#!/usr/bin/env python

import json
from sys import stdout
from queue import Queue
from threading import Thread
import subprocess
import os
import psutil
import alsaaudio

PATH_ERROR = subprocess.check_output(['get-icon', 'system-error']).decode('utf-8')
PATH_MUTED = subprocess.check_output(['get-icon', 'audio-volume-muted-symbolic']).decode('utf-8')
PATH_LOW = subprocess.check_output(['get-icon', 'audio-volume-low-symbolic']).decode('utf-8')
PATH_MEDIUM = subprocess.check_output(['get-icon', 'audio-volume-medium-symbolic']).decode('utf-8')
PATH_HIGH = subprocess.check_output(['get-icon', 'audio-volume-high-symbolic']).decode('utf-8')


def runner(current_path):
    command = ["pactl", "subscribe"]
    proc = proc = subprocess.Popen(command ,stdout=subprocess.PIPE)
    for line in iter(proc.stdout.readline, ''):
        line = line.rstrip().decode('utf-8')
        if line.split(' ')[1] == "'change'":
            mixer = alsaaudio.Mixer()
            current_path = writer(current_path, mixer.getmute()[0] == 1, mixer.getvolume()[0])


def writer(current_path, muted, volume):
    new_path = PATH_ERROR
    if muted:
        new_path = PATH_MUTED 
    else:
        if volume == 0:
            new_path = PATH_MUTED
        elif volume < 33:
            new_path = PATH_LOW
        elif volume < 66:
            new_path = PATH_MEDIUM
        else:
            new_path = PATH_HIGH

    if new_path != current_path:
        stdout.write(f"{new_path.strip()}\n")
        stdout.flush()
        return new_path
    else:
        return current_path


mixer = alsaaudio.Mixer()
current_path = writer(PATH_ERROR, mixer.getmute()[0] == 1, mixer.getvolume()[0])
Thread(target=runner, args={current_path,}).start()

