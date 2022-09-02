## 为Android 4.4.4编译 openssl 说明
0. 依赖
    1. NDK r20
1. 克隆```openssl```到当前目录，并切换到 ```OpenSSL_1_1_1-stable```分支
   ```
   git clone https://github.com/openssl/openssl.git
   git checkout OpenSSL_1_1_1-stable
   ```
2. 设置环境变量
    ```export NDK_ROOT=/Users/{你的实际路径}/sdk/ndk/20.1.5948944```
3. 开始编译，编译生成的文件在```output```目录，Android 4.4.4 只支持```arm```(```armeabi-v7a```)和```x86```两种架构
    ```./launcher.sh```

## 编译```Android 4.4.4```版本协议栈
1. 拷贝上面编译生成的```libcrypto.a```和```libssl.a```到```mars/openssl/openssl_lib_android```的对应目录
    > ```arm```对应```armapi-v7a```
2. 编译协议栈，但```abiFilter```未生效，编译生成的```aar```包含了```arm64-v8a```和```x86_64```架构的```so```文件，需要解压```aar```，删除```arm64-v8a```、```x86_64```、```jni/arm64-v8a```和```jni/x86_64```，然后用```zip```压缩工具压缩，并后缀名为```.aar``

## 致谢
本项目，参考了[Tutorial: Compile OpenSSL 1.1.1 for Android application](https://proandroiddev.com/tutorial-compile-openssl-to-1-1-1-for-android-application-87137968fee)，脚本等也是基于其修改

