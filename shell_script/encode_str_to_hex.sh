#!/bin/bash
echo -n $1 | xxd -p | xargs -I {} echo '0x'{}
