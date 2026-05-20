#!/bin/bash

tv_ip="192.168.0.249"

# Send explicit power off command (not toggle)
bscpylgtvcommand "$tv_ip" power_off

