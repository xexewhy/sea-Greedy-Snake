# sea-Greedy Snake

## 项目背景    
该项目是基于sea的简易贪吃蛇游戏，由相关besys3项目移植。    
编程实验软件平台为 VIVADO 2019.1 版本，选用芯片均为 xc7s15ftgb196-1。用到的附加外设包括：Mini HDMI 转 HDMI 线、显示器、CH05蓝牙模块、游戏手柄等。用到的辅助工具包括:Matlab R2018a 等。   
该游戏有简单模式和疯狂模式，两种模式蛇运动的速度不一样，对应难度也不一样。且可以用两种方式进行游戏：分别是SEA的拓展板—游戏手柄上的按键控制；以及手机app通过蓝牙远程控制。  

## 项目部分介绍

### drawsnake部分

在该部分，我们提供了FPGA部分的工程代码。在Vivado平台实现，且为纯硬核实现(verilog方式)。   
该部分更多内容参考该部分的readme文件


### matlab部分 
在该部分，我们提供了matlab部分的工程代码。主要为相关图像的coe文件生成。    
该部分更多内容参考该部分的readme文件

## 项目的基本结构

![image](https://github.com/xexewhy/sea-Greedy-Snake/blob/master/picture.png)

