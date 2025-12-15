#!/bin/bash

wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz -O /tmp/go1.16.5.linux-amd64.tar.gz
mkdir -p ./bin/golang/1.16.5
sudo tar -C ./bin/golang/1.16.5 -xzf /tmp/go1.16.5.linux-amd64.tar.gz
rm /tmp/go1.16.5.linux-amd64.tar.gz