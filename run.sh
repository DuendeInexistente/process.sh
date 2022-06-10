#!/bin/bash
./list.sh
./dl.sh $@ $(./list.sh)
./process.sh
