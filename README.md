# GitClub-Flutter

#### 一、Flutter的简介
Flutter是谷歌最早于2015年Dart开发者峰会亮相并推出的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面，目的是能够以每秒120帧的速度持续渲染，基于该特性Flutter正在被用作一些游戏开发。Flutter可以与现有的代码一起工作，被越来越多的开发者和组织使用，并且Flutter是完全免费且开源的，去年12月份Flutter1.0稳定版正式推出。[Flutter中文网](https://flutterchina.club/)
#### 二、GitClub的简介
GitClub是一款分享一些优秀的、新的Android开源库，一些重要的Android类的技术文章，以及一些程序开发业内的重要新闻，让感兴趣的伙伴利用零碎时间，如挤地铁、蹲大号、等女朋友的时候刷刷我们的小程序。当然以后也会增加其他开发语言的受众群体，java，javaEE，javaScript，C/C++，IOS，Html，PHP，Physon等等。
#### 三、主要内容
##### 1、Flutter引入第三方库的pub仓库地址(https://pub.dartlang.org/packages/)
##### 2、个人开发观点
首先个人觉得国内使用Flutter开发的公司并不算多，所以很多技术不够成熟，从而碰到开发中一旦碰到问题，有一部分百度的话是可以解决的，但是很多时候百度搜索到的东西并不是自己想要的（只是个人观点），而国外对于Flutter的开发是相对比较成熟的，所以Google搜索是非常有必要的，本人在项目中遇到的多个问题最终都是Google到的结果。Flutter作为Google推出的跨平台方案，第一个优势就是其性能和UI效果可以说无限接近原生，
再其次就是其超强的跨平台能力，大家可以看下面的Flutter SDK中的图，  

![](https://user-gold-cdn.xitu.io/2019/1/23/1687a177daaf675c?w=601&h=186&f=png&s=6700)

![](https://user-gold-cdn.xitu.io/2019/1/23/1687a16c0fe7887a?w=426&h=211&f=png&s=5400)
这是几个意思啊，好吓人啊，难道支持所有平台？呵呵，自己去体会吧，这个API已经可以看出Google的野心。第一个TargetPlatform中的意思其实是提供判断当前手机系统的平台版本，以便于开发者进行差异化处理，后一个嘛，要等，现在我还不敢把所有的事情说死，毕竟像Google这种公司说不定炒的很火的产品，第二天就宣布不做了，这个也是常事，现在把事情说的太死，以后万一没火起来岂不是自己打脸。言归正传，使用Flutter开发首先必须要安装Flutter的SDK，以及配置一些环境，这个自行搜索，今天我们的主要内容是[分享项目GitHub地址](https://github.com/AICareless/GitClub-Flutter)
##### 3、Flutter和Fuchsia系统的关系
既然主角是Flutter那就顺带介绍下Fuchsia系统，目前移动操作系统最流行的莫过于Android和iOS两个阵营，而Fuchsia与两者完全不同，Android是基于Linux内核，所以内存管理机制与Linux很相似，这就是Android始终存在一个弊端，也就是JVM的存在，虚拟机的存在是导致Android手机负载过重的一个根本问题，可以想象一下当你打开一个应用程序，系统会自动为该程序创建并维护一个虚拟机，当应用创建过多的时候，运行内存占用会越来越大，这就是大家所经常所说的为什么Android手机4G的运行内存为何还敌不过iOS 2G的内存？这就是体现iOS比Android稳定的一个例子了（勿喷，本人也是Android阵营）。还有一个因素就是Android当今市场碎片化太过严重，几乎国内安卓手机都用厂商的定制ROM，Google想缩紧权限也是有心无力，那么Fuchsia的出现就是为了解决这些弊端，而且Fuchsia如今已被证实将支持兼容Android应用，并且Fuchsia 是使用 Flutter SDK 开发的，所以 Fuchsia 的一部分可以在 Android 设备上运行。不过Android的小伙伴也不必过于担心，针对Fuchsia系统的正式出现到普及还未可知，但技多不压身，学习并入手Flutter还是很有必要的。

#### 四、效果展示
先来看一下效果页面（直接完全基于Flutter脚手架开发，没有专业UI设计，UI不够完美敬请谅解）。

<center class="half">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d8e6a1d202fd?w=117&h=248&f=jpeg&s=8262">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d92cef8a1ef8?w=117&h=248&f=jpeg&s=10704">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d92dc5c3e6e1?w=117&h=247&f=jpeg&s=4073">
</center>

<center class="half">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d92eb26a2e6a?w=117&h=247&f=jpeg&s=10334">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d92f4617dd50?w=117&h=247&f=jpeg&s=4689">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d92ffc05877d?w=117&h=247&f=jpeg&s=7866">
</center>

<center class="half">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d9308b10d5a1?w=117&h=247&f=jpeg&s=11744">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d9312dfcc6a5?w=117&h=247&f=jpeg&s=9446">
    <img src="https://user-gold-cdn.xitu.io/2019/1/24/1687d931b5c36e9c?w=117&h=247&f=jpeg&s=7629">
</center>
