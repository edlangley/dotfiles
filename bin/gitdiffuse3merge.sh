#!/bin/sh -x
diffuse -t "$2" "$1" -t "$1" "$3" -t "$2" "$4" "$3"

