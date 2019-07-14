EYDouYin 该项目主体框架是模仿抖音框架实现
=======================

## 首页
### 首页左滑 三方（GKNavigationBarViewController）实现
## 关注
## 消息
## 个人
### 个人中心 与 Swift 语言、Flutter 语言、React Native 语言的混合开发

# 项目如何使用？

## 第一步: clone 项目

方式一: (SSH) 
```git clone git@github.com:lieryang/EYDouYin.git```
方式二: (HTTPS) 
```git clone https://github.com/lieryang/EYDouYin.git```

## 第二步: 重新生成 my_flutter 模块(本来不需要的,目前没有找到解决方案)

### 1.保存 EYDouYin/my_flutter/main.dart 的源文件

### 2.重新生成 my_flutter 模块
```cd EYDouYin```
```flutter create -t module my_flutter```
注意!!! 是重新生成 Flutter 支持的模块 不是通过flutter 指令生成项目  ~~flutter create my_flutter~~

### 3.将第一步保存的 main.dart文件 覆盖掉 EYDouYin/my_flutter/main.dart 文件
注意是覆盖

## 第三步: 安装工程需要的三方库(OC、Swift、Flutter 支持、React Native 支持)

```cd ios```
```pod install```
