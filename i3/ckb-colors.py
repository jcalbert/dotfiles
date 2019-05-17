#!/usr/bin/env python
# Note: this reques that the ckb-next-daemon be installed and running
# also requires i3ipc

import i3ipc
import subprocess

cmd_file = "/dev/input/ckb1/cmd"

key_list = ['urgent','focused','visible','inactive','off']


color_names = {'white'  : 'ffe0ff',
                'teal'  : '00e1ff',
                'pink'  : 'ff00a9',
                'green' : '28ff00',
                'red'   : 'ff0000',
                'black' : '000000',
                'yellow': 'ffd000'}

color_map = {'urgent'  : color_names['green'],
             'focused' : color_names['red'],
             'visible'  : color_names['yellow'],
             'inactive': color_names['white'],
             'off'     : color_names['black']}


i3 = i3ipc.Connection()

def init():
    states = {k:[] for k in key_list}
    states['off'].extend(range(1,19))

    js = i3.get_workspaces()

    for j in js:
        num = j['num']
        states['off'].remove(num)
        for k in key_list[:3]:
            if j[k]:
                states[k].append(num)
                break
        else:
            states['inactive'].append(num)

    set_lights(states)

def set_lights(states):
    with open(cmd_file, 'w') as f:
        for k in key_list:
            nums = states[k]
            if len(nums) == 0:
                continue
            color = color_map[k]
            kb_cmd = 'rgb ' + ','.join('g'+str(n) for n in nums) + ':' + color
            f.write(kb_cmd+'\n')

def update(self, event):
    states = {k:[] for k in key_list}

    if event.change == 'focus':
        states['focused'].append(event.current.num)
        #states['inactive'].append(event.old.num)
        try:
            if event.old.visible:
                states['visible'].append(event.old.num)
            else:
                states['inactive'].append(event.old.num)
        except:
            ws = i3.get_workspaces()
            for w in ws:
                if w['num'] == event.old.num:
                    if w['visible']:
                        states['visible'].append(event.old.num)
                    else:
                        states['inactive'].append(event.old.num)
                    break

    elif event.change == 'init':
        states['focused'].append(event.current.num)
    elif event.change == 'empty':
        states['off'].append(event.current.num)
    elif event.change == 'urgent':
        states['urgent'].append(event.current.num)
    else:
        raise NotImplementedError('change: {} not handled'.format(event.change))
    
    set_lights(states)

init()
i3.on('workspace', update)
i3.main()
