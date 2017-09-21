# slambook
# slambook (中文说明)

Workflow:

-   **在 VirtualBox 安装 Ubuntu 16.04，macOS 通过 ssh 连接上去**

    配置 SSH key：

    ```bash
    $ ssh-copy-id -p 3022 -i ~/.ssh/id_rsa.pub tzx@localhost
    /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/Users/zxtang/.ssh/id_rsa.pub"
    /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
    /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
    tzx@localhost's password:

    Number of key(s) added:        1

    Now try logging into the machine, with:   "ssh -p '3022' 'tzx@localhost'"
    and check to make sure that only the key(s) you wanted were added.
    ```

    然后就可以免密码登录了：

    ```bash
    $ ssh -p 3022 tzx@localhost
    ```

-   **用 CLion 打开本地代码**

    CMakeLists.txt 里面加上本地的头文件路径：

    ```cmake
    include_directories(~/dev/libs/eigen-eigen-5a0156e40feb)
    ```

-   **修改代码，上传到 Ubuntu 运行**

    ```bash
    $ rsync -a ./ --rsh='ssh -p3022' tzx@localhost:~/git/slambook
    ```

    You can use `make` to run this command.

# 目录

-   [ch2 概述，cmake基础](ch2/README.md)

    介绍了 CLion 如何配置调试远程代码。

-   [ch3 Eigen，三维几何](ch3/README.md)


    如何在 CLion 里面配置库？

    Eigen 库。

-   [ch4 Sophus，李群与李代数](ch4/README.md)

-   ch5 OpenCV，图像与相机模型
-   ch6 Ceres and g2o，非线性优化
-   ch7 特征点法视觉里程计
-   ch8 直接法视觉里程计
-   ch9 project
-   ch10 Ceres and g2o，后端优化1
-   ch11 g2o and gtsam，位姿图优化
-   ch12 DBoW3，词袋方法
-   ch13 稠密地图构建