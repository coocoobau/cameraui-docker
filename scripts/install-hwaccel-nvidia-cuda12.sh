#!/usr/bin/env bash
# nvidia-cuda12 flavor, same runtime setup as nvidia on the CUDA 12 base image
exec bash "$(dirname "$0")/install-hwaccel-nvidia.sh"
