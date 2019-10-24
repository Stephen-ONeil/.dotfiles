#!/usr/bin/env bash

(cd ./mac-os && stow --ignore=\.DS_Store -t $HOME *)
(cd ./common && stow -t $HOME *)