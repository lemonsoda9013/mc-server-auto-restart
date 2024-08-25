# mc-server-auto-restart

[English](#introduction)

[中文](#简介)

## Introduction

A Minecraft server startup batch file script on Windows that enables auto restart and prevents the server from hanging on stop/restart.

> If your server doesn't exit on "stop" (such as this [issue](https://gitlab.com/horrific-tweaks/bingo/-/issues/13) from Yet Another Bingo) and prevent restarting, this script will help.

## Usage

First, you need to edit the ```TARGET_STRING```, the ```JAR_PATH``` and the ```PORT``` in the .bat file.

* ```TARGET_STRING```: The string used to trigger a restart, should only appear once when the server is stopping.
* ```JAR_PATH```: Your executable JAR file's name, such as ```server.jar```.
* ```PORT```: The port your server is running on, such as ```25565```.

Then, you can modify the parameters used for startup.

```
start /B java -Xms2G -Xmx4G -jar %JAR_PATH% > temp_output.log 2>&1
```

* ```-Xms2G```: Minimum RAM allocated to the server is 2G. (Change it as you like)
* ```-Xmx4G```: Maximum RAM allocated to the server is 4G. (Change it as you like)
* ```nogui```: If you don't want to use default MC server GUI, add it between ```%JAR_PATH%``` and ```>``` .

When you've completed the edition, save the changes and double-click the file to start the server.

## How it works

After the server starts, the script retrieves the process ID using the port. The server's output is written to a temporary file ```temp_output.log```. When the specific string is detected in the server's output, the process will be forcibly terminated.

## 简介

用于Windows的Minecraft服务器启动脚本，能在服务器关闭后自动重启，并且避免了服务器不能正常关闭导致自动重启失效的问题。

## 用法

首先，你需要修改文件中的```TARGET_STRING```、```JAR_PATH```和```PORT```。

* ```TARGET_STRING```: 用于触发重启的字符串，只应该在服务器关闭时出现一次。
* ```JAR_PATH```: 服务器JAR文件的名字，例如```server.jar```。
* ```PORT```: 服务器运行所用的端口，例如```25565```。

然后，你可以修改用于启动服务器的参数。

```
start /B java -Xms2G -Xmx4G -jar %JAR_PATH% > temp_output.log 2>&1
```

* ```-Xms2G```: 分配给服务器的最小内存为2G。(按情况修改)
* ```-Xmx4G```: 分配给服务器的最大内存为4G。(按情况修改)
* ```nogui```: 如果你不需要MC服务器的默认界面，把这个参数放在```%JAR_PATH%```和```>```中间。

完成更改并保存之后，双击.bat文件就可以启动服务器。

## 原理

服务器启动之后，脚本会使用端口获取进程ID。服务器的输出会被写入到一个临时文件```temp_output.log```。如果从服务器输出中检测到指定的字符串，进程就会被强行停止。



