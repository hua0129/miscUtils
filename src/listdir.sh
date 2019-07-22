#!/bin/bash

ls | sed "s:^:`pwd`/:" | sed "s/^/$HOSTNAME:/g"
