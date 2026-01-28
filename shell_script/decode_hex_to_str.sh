#!/bin/bash
#
echo -n 0x$1 | xxd -r |  tr -d '\%'
