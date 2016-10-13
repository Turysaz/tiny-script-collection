#!/bin/bash

# steam updates might install broken versions of
# libstdc++ from time to time, this might fix it.
# 
# taken from a discussion on github;
# original post by Kuro-Maii

find .steam -name libstdc++.so.6 | xargs -I get_lost mv get_lost{,_bak}
