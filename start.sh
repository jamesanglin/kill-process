#!/bin/bash

while true; do date; bash /opt/application/killprocess/killprocess.sh kill top cpu; sleep 60; done