#!/usr/bin/env bash
# nvidia-tensorrt flavor: the nvidia setup plus the TensorRT runtime for the
# ONNX plugin's tensorrt provider (dlopens libnvinfer, libnvinfer_plugin,
# libnvonnxparser)
set -euo pipefail
bash "$(dirname "$0")/install-hwaccel-nvidia.sh"

apt-get update
apt-get install -y --no-install-recommends \
    libnvinfer10 libnvinfer-plugin10 libnvonnxparsers10

rm -rf /tmp/* /var/tmp/*
echo "==> nvidia-tensorrt hwaccel done"
