FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

#basic utilities and tensorflow dependencies

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        wget \
        git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



# install PIP

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py



# install some keras dependencies

RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        sklearn \
        pandas \
        Pillow \
        && \
    python -m ipykernel.kernelspec



#adding a test python application inside keras directory of the image

ADD mnist_cnn.py /keras/



# Adding CUDNN libraries

ADD cudnn-8.0-linux-x64-v5.1.tgz /home/



# Changing current working directory

WORKDIR /home/



# Moving CUDNN libraries to CUDA Toolkit Directory

RUN cp -P cuda/include/cudnn.h /usr/local/cuda-8.0/include

RUN cp -P cuda/lib64/libcudnn* /usr/local/cuda-8.0/lib64

RUN chmod a+r /usr/local/cuda-8.0/include/cudnn.h /usr/local/cuda-8.0/lib64/libcudnn*



# Setting Environment variables necessary for CUDA and CUDNN to work effectively

ENV LD_LIBRARY_PATH /usr/local/cuda-8.0/lib64:/usr/local/cuda-8.0/extras/CUPTI/lib64:${LD_LIBRARY_PATH}

ENV CUDA_HOME /usr/local/cuda-8.0:${CUDA_HOME}

ENV PATH /usr/local/cuda-8.0/bin:${PATH}



# Install TensorFlow GPU version.

RUN pip install tensorflow-gpu


# Install Keras

RUN pip install keras


EXPOSE 5000


# Set up jupyter notebook config.

WORKDIR /root

RUN mkdir .jupyter

COPY jupyter_notebook_config.py /root/.jupyter/

WORKDIR /

RUN mkdir notebook

COPY run_jupyter.sh /

WORKDIR /notebook

EXPOSE 4000

CMD exec /bin/bash -c "jupyter notebook --allow-root"

