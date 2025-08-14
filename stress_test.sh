#!/bin/bash

# Launching stress test on node
sudo stress-ng --cpu 4 --io 2 --vm 1 --vm-bytes 512M --verbose --timeout 60s