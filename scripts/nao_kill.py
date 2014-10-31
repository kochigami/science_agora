#!/usr/bin/env python
#-*- coding: utf-8 -*-

from naoqi import ALProxy
import sys

PORT = 9559

if len(sys.argv) > 1:
    IP = sys.argv[1]
else:
    print "Usage: python nao_kill.py nao_ip"
    exit()

autolife=ALProxy("ALAutonomousLife", IP, PORT)
autolife.setState("disabled")
