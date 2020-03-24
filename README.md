## JXCategoryKit  系统基础类扩展
* 包含 Foundation.framework 内的NSTimer，NSObject，NSNull，NSFileManager，NSString，NSDictionary，NSError，NSBundle，NSArray 类扩展
* 包含 UIKit.framework内的UIWindow，UIViewController，UIView，UITextField，UITableViewCell，UIImage，UIDevice，UIColor，UIButton，UITabBarController，UIApplication 类扩展
* 包含 CoreLocation.framework内的CLLocation 类扩展
* 包含 QuartzCore.framework 的CALayer 类扩展

📜<font color=Blue>提示：所有类扩展方法均是整理总结的自定义方法，无hook系统类方法和实例方法的实现，降低了对工程中代码的侵入性，并且方法名均以 jx_ 开头，避免了与其它类扩展自定义方法名冲突。</font>

## 引用

* 可以通过pod进行引用：pod 'JXCategoryKit'

## 内容

* QuartzCore
    * CALayer
      * 摇动动画
* CoreLocation
    * CLLocation
      * 世界标准地理坐世标(WGS-84) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
      * 中国国测局地理坐标（GCJ-02） 转换成 世界标准地理坐标（WGS-84）
      * 世界标准地理坐标(WGS-84) 转换成 百度地理坐标（BD-09)
      * 中国国测局地理坐标（GCJ-02）<火星坐标> 转换成 百度地理坐标（BD-09)
      * 百度地理坐标（BD-09) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
      * 百度地理坐标（BD-09) 转换成 世界标准地理坐标（WGS-84）
      * 两个坐标间的距离 
* UIKit
    * UIWindow
      * 获取主窗体 UIWindow
      * 获取当前主控制器 UIViewController
    * UIViewController
      * Alert系统提示
      * AlertSheet系统提示
    * UIView
      * 添加圆角，适用于自动布局，传入设置frame
      * 添加圆角,适用于已知frame，即非自动布局
      * 添加圆角，适用于已知frame，即非自动布局，圆角位置为UIRectCornerAllCorners
      * 添加圆角，适用于自动布局，传入设置frame，圆角位置为UIRectCornerAllCorners
      * 绘制虚线
      * x，y，width，height，centerX，centerY，size，origin，maxX，maxY
    * UITextField
      * 当前输入是否高亮 true 高亮 false 无高亮
    * UITableViewCell
      * 显示缩放效果
      * 显示缩进效果
      * 显示旋转效果
      * 设置分割线左边距,右边距
    * UIImage
      * 裁剪为有边界的圆形图片
      * 裁剪图片中的一块区域
      * 拉伸图片
      * 改变图片尺寸
      * 裁剪图片圆角
      * 图片模糊
      * 更新图片的方向，直立显示
      * 转换图片为png格式的base64编码
      * 拼接长图
      * 根据图片url获取网络图片尺寸
      * 压缩图片
      * 生成带圆角的颜色图片
      * 生成矩形的颜色图片
      * 生成渐变色的UIImage
      * 生成三角图片
      * 生成二维码
      * 获取二维码内内容
    * UIDevice
      * 获取通用 - 关于本机 - 名称
      * 获取设备类型
      * 获取系统名称 iOS
      * 获取设备系统版本 13.3/12.0
      * 获取设备电量
      * 获取手机本地语言 zh-Hans-CN/en
      * 获取 WiFi 信号强度，只有在WiFi显示时才能获取到
      * 获取IDFA
      * 获取IDFV
      * 获取UUID
      * 获取设备名称，例：iPhone 11 Pro Max
      * 获取当前设备可用系统内存(单位：MB）
      * 获取当前设备磁盘总容量(单位：MB）
      * 获取当前设备磁盘剩余容量(单位：MB）
    * UIColor
      * 传入十进制颜色生成UIColor
      * 传入十六进制颜色生成UIColor
      * 传入十六进制字符串色值生成UIColor
      * UIColor转16进制
      * UIColor转换为颜色字符串，例：0xffff0000
      * UIColor转换为颜色字符串，例：#ff0000
      * iOS 13.0 亮暗颜色设置
    * UIButton
      * 设置自定义图片文字位置按钮
      * 开始加载菊花动画
    * UITabBarController
      * 设置导航栏背景颜色和阴影颜色
      * 设置tabbar背景颜色和阴影颜色
      * 设置tabbar 文字normal颜色和selected颜色
      * tabbar动态显示和隐藏
    * UIApplication
      * 通知是否启用
      * 跳转App系统通知设置
      * 注册通知
