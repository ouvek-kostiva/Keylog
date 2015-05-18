#!/bin/bash

for i in 1 2 3 4 5
do
  showkey >> ~/Keylog/showkey.txt
  ruby ~/Keylog/Versions/log_v1.rb
done

