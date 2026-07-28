#!/usr/bin/env bash
# nvidia flavor — CUDA runtime comes from the base image; the NVENC/NVDEC driver
# libs, plus the NVIDIA OpenCL/Vulkan ICDs, are injected at runtime by the host's
# NVIDIA Container Toolkit (needs NVIDIA_DRIVER_CAPABILITIES incl. compute,graphics).
set -euo pipefail
echo "==> hwaccel: nvidia"

# enable universe + multiverse (deb822) for the VA-API drivers below
if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then
    sed -i 's/^Components: .*/Components: main restricted universe multiverse/' \
        /etc/apt/sources.list.d/ubuntu.sources
fi

apt-get update

apt-get install -y --no-install-recommends \
    ocl-icd-libopencl1 \
    libvulkan1 \
    mesa-vulkan-drivers \
    vainfo clinfo vulkan-tools || true

# VA-API drivers for the iGPU: multi-GPU boxes decode on Intel/AMD via
# /dev/dri while CUDA does inference — pass /dev/dri alongside the nvidia
# runtime and pick vaapi in the camera's decoder setting
apt-get install -y --no-install-recommends \
    intel-media-va-driver-non-free \
    i965-va-driver \
    mesa-va-drivers || true

rm -rf /tmp/* /var/tmp/*
echo "==> nvidia hwaccel done"
