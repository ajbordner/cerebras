# Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
# SPDX-FileCopyrightText: Copyright (c) 2021 NVIDIA CORPORATION & AFFILIATES
# SPDX-License-Identifier: MIT

# run docker daemon with --default-runtime=nvidia for GPU detection during build
# multistage build for DGL with CUDA and FP16

# NGC container for Python 3.8, Pytorch 1.12, CUDA 11.6.1
ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:22.03-py3

FROM ${FROM_IMAGE_NAME}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y git build-essential python3-dev make cmake emacs \
    && rm -rf /var/lib/apt/lists/*

FROM ${FROM_IMAGE_NAME}

WORKDIR /workspace/lm

ADD requirements.txt .
RUN pip install -r requirements.txt
ADD . .

ENV OMP_NUM_THREADS=1
ENV PYTHONPATH=/workspace/lm
ENV TRANSFORMERS_CACHE=/workspace/lm/.cache/transformers
ENV HF_DATASETS_CACHE=/workspace/lm/.cache/huggingface
ENV JUPYTER_RUNTIME_DIR=/workspace/lm/.local/share/jupyter/runtime
ENV JUPYTER_DATA_DIR=/workspace/lm/.local/share/jupyter
ENV JUPYTER_CONFIG_DIR=/workspace/lm/.jupyter
