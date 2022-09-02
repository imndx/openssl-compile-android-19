#!/bin/bash
set -e
set -x

# Set directory
SCRIPTPATH=`realpath .`
export ANDROID_NDK_HOME=${NDK_ROOT}
OPENSSL_DIR=$SCRIPTPATH/openssl
#OPENSSL_DIR=.
/bin/rm -f $OPENSSL_DIR/.gitignore

# Find the toolchain for your build machine
toolchains_path=$(python toolchains_path.py --ndk ${NDK_ROOT})

# Configure the OpenSSL environment, refer to NOTES.ANDROID in OPENSSL_DIR
# Set compiler clang, instead of gcc by default
CC=clang

# Add toolchains bin directory to PATH
PATH=$toolchains_path/bin:$PATH

# Set the Android API levels
ANDROID_API=19

# Set the target architecture
# Can be android-arm, android-arm64, android-x86, android-x86_64 etc
architecture=android-arm

# Create the make file
cd ${OPENSSL_DIR}
./Configure ${architecture} -D__ANDROID_API__=$ANDROID_API

# Build
make

# Copy the outputs
OUTPUT_INCLUDE=$SCRIPTPATH/output/include
OUTPUT_LIB=$SCRIPTPATH/output/lib/${architecture}
mkdir -p $OUTPUT_INCLUDE
mkdir -p $OUTPUT_LIB
cp -RL include/openssl $OUTPUT_INCLUDE
cp libcrypto.so $OUTPUT_LIB
cp libcrypto.a $OUTPUT_LIB
cp libssl.so $OUTPUT_LIB
cp libssl.a $OUTPUT_LIB

git clean -f -d

architecture=android-x86

# Create the make file
cd ${OPENSSL_DIR}
./Configure ${architecture} -D__ANDROID_API__=$ANDROID_API

# Build
make

# Copy the outputs
OUTPUT_LIB=$SCRIPTPATH/output/lib/${architecture}
mkdir -p $OUTPUT_LIB
cp libcrypto.so $OUTPUT_LIB
cp libcrypto.a $OUTPUT_LIB
cp libssl.so $OUTPUT_LIB
cp libssl.a $OUTPUT_LIB

git clean -f -d
