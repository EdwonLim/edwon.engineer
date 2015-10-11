title: 移动Hybrid开发加速器——模拟器
date: 2015-10-11 15:40:57
tags:
 - 移动
 - 模拟器
categories: 移动开发
---

{% centerquote %}
Hybrid App（混合模式移动应用）是指介于web-app、native-app这两者之间的app，兼具『Native App良好用户交互体验的优势』和『Web App跨平台开发的优势』。
{% endcenterquote %}

#### 移动 Hybrid 开发遇到的调试问题

随着 Hybrid 思想的推广和其技术的日益成熟，以及 PhoneGap、React Native、Titanium 以及咱公司的 Hy 这些 Hybrid 形式框架的推出，开发者使用这项技术创建 Hybrid App 的场景越来越多。

与此同时，在开发中遇到的问题也逐渐显现，由于前端代码需要和Native代码进行逻辑上的交互，而且开发人员都是前端工程师，因此『调试异常繁琐』这个问题尤为显著。

对于调试问题，现有的解决方式是:

* 利用 Chrome 开发者工具的设备模拟选项，来模拟移动设备上的浏览器，同时，利用 Chrome 插件来模拟前端与Native的交互。
* 真机调试，将 App 装到真实的移动设备上，进行调试。

对于，第一种方案 Chrome 插件不可能完全一致的模拟 Native 环境，例如多页面通信、原生应用服务环境等，是非常难以模拟的；
而第二种方案，需要通过配置 Host、DNS 或者代理将前端资源指向可调试的代码的方式繁琐、iOS可调试App的安装限制及真机设备成本问题，也是不可避免的。

从上面的描述，我们看到调试是十分繁琐的，严重影响开发的效率。

在这里，我将要准备分享一个较为简便的调试方式——利用模拟器。

#### 对模拟器的误解

对于模拟器，前端开发人员甚至Android开发人员都使用甚少，甚至有很多误解。

* 模拟器是Native开发人员用的，前端开发人员使用起来会很难，并不能快速上手。 By 前端开发人员
* 模拟器太慢，严重影响开发效率。 By Android开发人员
* 模拟器中的App是Xcode编译出来的，使用的人需要源代码才能把App装到自己电脑上的模拟器上。 By iOS开发人员
* 等等

这种种问题我认为都是对模拟器的误解，其实模拟器很好用的。

#### 模拟器现状

##### iOS 模拟器

对于 iOS 模拟器，iOS 开发者并不陌生，安装了 Xcode 后，你的 Mac 就会拥有模拟器（最新版本的，指定版本需要自行下载）。

iOS 模拟器和真机差别微乎其微，开发者完全在模拟器上完成项目的开发。

Xcode 提供了 `xcrun simctl` 命令来控制模拟器。

```
~ xcrun simctl
Usage: simctl [--noxpc] [--set <set path>] <subcommand> ... | help [subcommand]
Command line utility to control the Simulator

For subcommands that require a <device> argument, you may specify a device UDID
or the special "booted" string which will cause simctl to pick a booted device.
If multiple devices are booted when the "booted" device is selected, simctl
will choose one of them.

Subcommands:
   create              Create a new device.
   delete              Delete a device or all unavailable devices.
   pair                Create a new watch / phone pair.
   unpair              Unpair a watch and phone phone.
   erase               Erase a device's contents and settings.
   boot                Boot a device.
   shutdown            Shutdown a device.
   rename              Rename a device.
   getenv              Print an environment variable from a running device.
   openurl             Open a URL in a device.
   addphoto            Add photos to the photo library of a device.
   install             Install an app on a device.
   uninstall           Uninstall an app from a device.
   get_app_container   Print the path of the intsalled app's container
   launch              Launch an application by identifier on a device.
   spawn               Spawn a process on a device.
   list                List available devices, device types, runtimes, or device pairs.
   icloud_sync         Trigger iCloud sync on a device.
   help                Prints the usage for a given subcommand.
```

对于前端开发人员，需要知道 `xcrun simctl install {SimulatorID} {AppPath}` 这个命令，来给指定的模拟器安装 App。

当然，也需要知道怎么打开模拟器，就是下面的命令。

```
open -a "iOS Simulator" --args -CurrentDeviceUDID {SimulatorID}
```

而 `xcrun simctl list` 来显示模拟器的列表来查看ID。

##### Android 模拟器

对于 Google 提供的模拟器，其性能和效率真不敢恭维，连 Android 开发人员都嫌弃。

但是，一个号称最快Android模拟器的应用横空出世，让利用Andoird模拟器调试不是梦，那就是 **Genymotion**。

Genymotion 提供免费版本，其免费的功能，足够前端开发人员用于调试，提供 Mac 和 Windows 版本。（收费功能主要是和IDE的结合、相机等高级功能的模拟等。）

Genymotion 利用 VisualBox 来运行 Android 系统，用电脑的GPU进行渲染，其效率可想而知。

![Genymotion](http://ww4.sinaimg.cn/bmiddle/71c50075gw1ewxb8swnxlj21kw10c7ds.jpg)

如图所示，用户可以下载不同机型的模拟器的，主流的Google、HTC、三星等的机型都被收录，用户可以直接下载使用。

安装应用，其实非常简单，即可以通过 `adb` 命令来安装，也可以直接将 apk安装文件 放到网盘里，在模拟器直接下载安装。

#### 什么样的 App 能装到模拟器里

##### iOS

App Store 上的和 ipa 包都不能装到模拟器上。那什么包可以装上呢？为模拟器定制的包可以。

iOS开发者需要通过 `xrunbuild` 命令来编译 iOS 项目时，加上参数即可。

```
-destination='platform=iphonesimulator'
```

用此命令构建出的App，可以安装到模拟器上。

##### Android

只要是 apk 的 App 都可以装到模拟器上。好爽是不是？

#### 其他技巧

* Android 4.4 App 的 WebView 需要调试，需要 Android 开发人员开启调试配置 `WebView.setWebContentsDebuggingEnabled(true); `。
* Genymotion 的模拟器配置电脑本机代理，ip 为 `10.0.3.2`。
* 如果在特定版本的Android和Rom上出问题，而 Genymotion 不提供，则必须使用真机调试。

#### 最后

使用模拟器开发，可以让前端开发效率更高，同时，在模拟器上调试过后，在真机上调试时，出现的问题会很少，大幅减少真机使用率，使真机资源有效利用。



{% centerquote %}
Thank You & Enjoy It！
{% endcenterquote %}
