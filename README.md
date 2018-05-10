# WZRootNavigationController

[![CI Status](http://img.shields.io/travis/arcangelw/WZRootNavigationController.svg?style=flat)](https://travis-ci.org/arcangelw/WZRootNavigationController)
[![Version](https://img.shields.io/cocoapods/v/WZRootNavigationController.svg?style=flat)](http://cocoapods.org/pods/WZRootNavigationController)
[![License](https://img.shields.io/cocoapods/l/WZRootNavigationController.svg?style=flat)](http://cocoapods.org/pods/WZRootNavigationController)
[![Platform](https://img.shields.io/cocoapods/p/WZRootNavigationController.svg?style=flat)](http://cocoapods.org/pods/WZRootNavigationController)

## iPhoneX效果

* 效果图(gif图压缩，实际效果请运行demo)

![animation](https://github.com/arcangelw/WZRootNavigationController/blob/master/ScreenShot/animation.gif)
 

![push&pop](https://github.com/arcangelw/WZRootNavigationController/blob/master/ScreenShot/push&pop.gif)


## Installation
很多应用需要给每个VC设置独立导航条，做成不同的视觉效果，同时转场交互也是一个头疼的问题，然后还需要全屏幕右滑返回，部分页面又有了侧边返回的变态需求，结合以往项目的各种蛋疼的需求问题和切换Swift的实际情况，写了这么一个库WZRootNavigationController，它实现了 RTRootNavigationController & FDFullscreenPopGesture & 
TransitionTreasury 完美结合[（纯属吹牛逼，就是为了项目需求硬生生套上的，为了兼容ObjC也是各种妥协，各位大佬走过路过求点评不足)]()


参照业内相关实现：

- [**RTRootNavigationController**](https://github.com/rickytan/RTRootNavigationController) 
  - ObjC实现独立导航栏,本项目层级结构跳转参考之

- [**TransitionTreasury**](https://github.com/DianQK/TransitionTreasury) 
  - Swift转场动画，本项目提供的几个转场动画参考之

- [**JTNavigationController**](https://github.com/JNTian/JTNavigationController)
  - 支持全屏返回
- [**FDFullscreenPopGesture**](https://github.com/forkingdog/FDFullscreenPopGesture)
  - 使用原生的 *UINavigationController*，在 `- (void)viewWillAppear` 中做处理
  - 支持全屏返回

- [菜鸟不生产代码，我们只是代码的搬运工]()




## Usage

一些基本使用和RTRootNavigationController基本一致的,请参考给出的demo

- 整体结构实现请参考[**点这儿**](https://github.com/arcangelw/WZRootNavigationController/blob/master/WZRootNavigaionController.mindnode)

![mind](https://github.com/arcangelw/WZRootNavigationController/blob/master/ScreenShot/mind.png)


通过wz_rootContentConfig设置 popGestureProcessing 和 animationProcessing,可以实现独立的手势和转场动画处理


WZRootNavigationController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WZRootNavigationController'
```

## Author

arcangelw, wuzhezmc@gmail.com

## License

WZRootNavigationController is available under the MIT license. See the LICENSE file for more info.
