#!/bin/sh -x
meld -n --diff "$2" "$1" --diff "$1" "$3" --diff "$2" "$4" "$3"

