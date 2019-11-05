FROM ubuntu:16.04

ENV CONAN_USER_HOME=~ \
        LLVM_VERSION=8.0 \
    PYENV_ROOT=/opt/pyenv \
    PATH=/opt/pyenv/shims:${PATH}

ARG llvmver=8

ADD llvm.list /
ADD llvm-snapshot.gpg.key /
ADD entrypoint /

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8611B7A28669BB93
# Pre-Req Repos
RUN apt update && \ 
 apt install -y software-properties-common gnupg apt-transport-https ca-certificates

RUN apt-add-repository 'deb http://apt.kitware.com/ubuntu/ xenial main'

RUN  apt-get upgrade -y && \
# Install pre-reqs
        mv llvm.list /etc/apt/sources.list.d/ && \
        apt-key add llvm-snapshot.gpg.key && \
        rm llvm-snapshot.gpg.key  && \
        apt-get update  &&\
        apt-get install -y \
        build-essential \
#Install Tool
        clang-$llvmver \
        clang-tools-$llvmver \
        clang-format-$llvmver \
        python-clang-$llvmver \
        libfuzzer-$llvmver-dev \
        lldb-$llvmver \
        lld-$llvmver \
        libc++-$llvmver-dev \
        libc++abi-$llvmver-dev \
        libomp-$llvmver-dev \
        wget \ 
        python3 \ 
        python3-pip \ 
        curl\ 
        git\ 
        cmake\
        libgmp-dev \
        libmpfr-dev \
        libmpc-dev \
        nasm \
        dh-autoreconf \
        libffi-dev \
        libssl-dev \
        ninja-build \
        pkg-config \
        subversion \
        zlib1g-dev \
        libbz2-dev \
        libsqlite3-dev \
        libreadline-dev \
        xz-utils \
        curl \
        libncurses5-dev \
        libncursesw5-dev \
        liblzma-dev \
        ca-certificates \
        autoconf-archive \
        libpython-dev \
        bison \
        flex

RUN chmod +x /entrypoint \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-8 100 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-8 100 \
    && update-alternatives --install /usr/bin/cc cc /usr/bin/clang-8 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-8 100 \
    && update-alternatives --install /usr/bin/cpp cpp /usr/bin/clang++-8 100

RUN groupadd 1001 -g 1001 \
    && groupadd 1000 -g 1000 \
    && groupadd 2000 -g 2000 \
    && groupadd 999 -g 999 \
    && useradd -ms /bin/bash conan -g 1001 -G 1000,2000,999 \
    && printf "conan:conan" | chpasswd \
    && adduser conan sudo \
    && printf "conan ALL= NOPASSWD: ALL\\n" >> /etc/sudoers 

RUN wget --no-check-certificate --quiet -O /tmp/pyenv-installer https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer \
    && chmod +x /tmp/pyenv-installer \
    && /tmp/pyenv-installer \
    && rm /tmp/pyenv-installer \
    && update-alternatives --install /usr/bin/pyenv pyenv /opt/pyenv/bin/pyenv 100 \
    && PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.1 \
    && pyenv global 3.7.1 \
    && pip install -q --upgrade --no-cache-dir pip \
    && pip install -q --no-cache-dir conan conan-package-tools \
    && chown -R conan:1001 /opt/pyenv \
    # remove all __pycache__ directories created by pyenv
    && find /opt/pyenv -iname __pycache__ -print0 | xargs -0 rm -rf \
    && update-alternatives --install /usr/bin/python python /opt/pyenv/shims/python 100 \
    && update-alternatives --install /usr/bin/python3 python3 /opt/pyenv/shims/python3 100 \
    && update-alternatives --install /usr/bin/pip pip /opt/pyenv/shims/pip 100 \
    && update-alternatives --install /usr/bin/pip3 pip3 /opt/pyenv/shims/pip3 100


RUN printf 'eval "$(pyenv init -)"\n' >> ~/.bashrc \
    && printf 'eval "$(pyenv virtualenv-init -)"\n' >> ~/.bashrc \
    && mv /usr/bin/lsb_release /usr/bin/lsb_release_bak

RUN mkdir -p ~/.conan/profiles/
ADD default ~/.conan/profiles/default

RUN apt-get install python2.7
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python2.7 get-pip.py
RUN pip2 install python-magic
RUN pip2 install wget
