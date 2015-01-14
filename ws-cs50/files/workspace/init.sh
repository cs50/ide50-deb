#!/bin/bash

: ${C9_PROJECT:?Environment variabel \$C9_PROJECT must be set}

shopt -s dotglob
mv ~/$C9_PROJECT/* ~/workspace
rm -rf $C9_PROJECT