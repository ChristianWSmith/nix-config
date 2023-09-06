#!/usr/bin/env python

import json
from sys import stdout
from queue import Queue
from threading import Thread
import subprocess
import os

ADD = '+'
REMOVE = '-'


def reader(out_queue):
    command = ["socat", "-u", f"UNIX-CONNECT:/tmp/hypr/{os.getenv('HYPRLAND_INSTANCE_SIGNATURE')}/.socket2.sock", "-"]
    proc = proc = subprocess.Popen(command ,stdout=subprocess.PIPE)
    for line in iter(proc.stdout.readline, ''):
        line = line.rstrip().decode('utf-8')
        if line.startswith("workspace"):
            out_queue.put((ADD, line.replace("workspace>>", "")))
        elif line.startswith("destroyworkspace"):
            out_queue.put((REMOVE, line.replace("destroyworkspace>>", "")))


def writer(in_queue, workspaces, active_workspace):
    
    while True:
        message = []
        for workspace in sorted(list(workspaces)):
            if workspace == active_workspace:
                message.append({'id': workspace, 'active': True})
            else:
                message.append({'id': workspace, 'active': False})
        stdout.write(f"{json.dumps(message)}\n")
        stdout.flush()
        
        add_remove, workspace = in_queue.get()
        if add_remove == ADD:
            workspaces.add(workspace)
            active_workspace = workspace
        elif add_remove == REMOVE:
            workspaces.discard(workspace)


workspaces = set(str(workspace['id']) for workspace in json.loads(subprocess.check_output(['hyprctl', 'workspaces', '-j']).decode('utf-8')))
active_workspace = str(json.loads(subprocess.check_output(['hyprctl', 'activeworkspace', '-j']).decode('utf-8'))['id'])
in_out_queue = Queue()
Thread(target=writer, args=(in_out_queue, workspaces, active_workspace,)).start()
Thread(target=reader, args=(in_out_queue,)).start()

