#!/usr/bin/env python

from sys import stdout
from threading import Thread
from subprocess import check_output, Popen, PIPE
from alsaaudio import Mixer
from time import sleep

PATH_ERROR = check_output(['get-icon', 'system-error']).decode('utf-8')
PATH_MUTED = check_output(['get-icon', 'audio-volume-muted-symbolic']).decode('utf-8')
PATH_LOW = check_output(['get-icon', 'audio-volume-low-symbolic']).decode('utf-8')
PATH_MEDIUM = check_output(['get-icon', 'audio-volume-medium-symbolic']).decode('utf-8')
PATH_HIGH = check_output(['get-icon', 'audio-volume-high-symbolic']).decode('utf-8')


def runner(current_path):
    command = ["pactl", "subscribe"]
    proc = proc = Popen(command ,stdout=PIPE)
    for line in iter(proc.stdout.readline, ''):
        line = line.rstrip().decode('utf-8')
        if line.split(' ')[1] == "'change'":
            mixer = Mixer()
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



mixer = None
while mixer is None:
    try:
        mixer = Mixer()
    except:
        sleep(1)
current_path = writer(PATH_ERROR, mixer.getmute()[0] == 1, mixer.getvolume()[0])
Thread(target=runner, args={current_path,}).start()

