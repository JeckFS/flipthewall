#!/bin/bash

base64 -d firststep.txt > secondstep.txt
# remove the prefix "ssr://"
cat secondstep.txt | sed -n 's/^ssr:\/\/\(.*\)/\1/w thirdstep.txt'

