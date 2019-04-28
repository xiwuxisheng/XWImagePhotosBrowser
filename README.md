# XWImagePhotosBrowser
这里是仿照微信图片浏览器制作的通用控件[XWImagePhotosBrowser](https://github.com/xiwuxisheng/XWImagePhotosBrowser)，主要包括一下特点:  
1>支持图片缩放和手势  
2>支持图片仿微信位置变换动画  
3>支持网络和本地图片数据模型，以协议作为适配器  
4>允许更换默认图及加入图片文字米描述  

# 效果显示图  
![效果图](http://i2.bvimg.com/685434/4742301bd8b7c601.gif)

## 核心代码使用范例  
![使用核心代码图](http://i1.bvimg.com/685434/c26879d0056ecd43.jpg)  

第一个expandPhotoBroswer方法用于打开图片浏览器  
后续两个代理方法用于处理位置动画，采集当前图片相册达到的位置及frame，来进行弹出和关闭的动画

## 适配  
语言换环境：Objective C
iOS系统：iOS 8.0++

## 安装

XWImagePhotosBrowser is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XWImagePhotosBrowser'
```

## 作者

xiwuxisheng, xiw@addcn.com

## License

XWImagePhotosBrowser is available under the MIT license. See the LICENSE file for more info.
