## JXCategoryKit  系统基础类扩展
* 包含 Foundation.framework 内的NSDate,NSTimer，NSObject，NSNull，NSFileManager，NSString，NSDictionary，NSError，NSBundle，NSArray 类扩展
* 包含 UIKit.framework内的UIWindow，UIViewController，UIView，UITextField，UITableViewCell，UIImage，UIDevice，UIColor，UIButton，UITabBarController，UIApplication 类扩展
* 包含 CoreLocation.framework内的CLLocation 类扩展
* 包含 QuartzCore.framework 的CALayer 类扩展

📜提示：所有类扩展方法均是整理总结的自定义方法，并且方法名均以 jx_ 开头，避免了与其它类扩展自定义方法名冲突。        
Hook系统方法的类有如下：            
UIButton：Hook了sendAction方法，并引出了在sendAction之前的一个实例方法。

### 如果您认为我整理总结的比较好，希望您给我一个star，您的支持是我坚持下去的动力。

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

* Foundation
    * NSTimer
      * 快速创建timer
      * 暂停Timer
      * 恢复Timer
      * 过一段时间继续Timer
    * NSObject
      * swizzle交换类方法
      * swizzle交换类实例方法
      * 判断方法是否在子类里override了
      * 判断当前类是否在主bundle里
      * 输出类方法
      * 输出类属性
      * 返回类属性字典
    * NSNull
      * nil空对象方法调用时安全处理
    * NSFileManager
      * 获取单个文件的大小
      * 向itunes共享文件夹中写入文件，即NSDocumentDirectory
      * 向文件写入数据
      * 快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷
      * 快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName，不创建文件
      * 快速返回沙盒中选定文件夹的路径
      * 快速返回沙盒中选定文件的路径
      * 快速返回沙盒中选定文件夹的路径
      * 判断文件是否存在
      * 创建目录(已判断是否存在，无脑用就行)
      * 计算指定路径下的文件是否超过了规定时间
      * 重置文件夹
      * 删除文件
      * 根据音频文件二进制流判断是否是amr格式音频
      * 路径是否是文件类型，true 文件类型 false 文件夹类型
      * 移动文件
    * NSString
      * 一段字符串添加关键字属性
      * 有效账号验证,数字和字母
      * 有效密码验证，数字和字母
      * 有效验证码验证
      * 手机号码验证
      * 中国移动手机号码验证
      * 中国联通手机号码验证
      * 中国电信手机号码验证
      * 身份证号码验证
      * 有效邮箱验证
      * 昵称有效验证
      * QQ号码验证
      * 微信号码验证
      * (个性签名，组织姓名，组织名称）验证
      * 车牌号码验证
      * 字符串是URL地址验证
      * 字符串纯汉字数字字母组成验证
      * 字符串纯字母数字验证
      * 字符串是否为汉字，字母，数字和下划线组成
      * 字符串是否包含表情
      * 字符串判断是否为整形数字
      * 字符串纯英文字母
      * 系统方法计算一段字符串的size
      * CoreText计算单行文本
      * CoreText计算多行文本size
      * URL编码解码
      * 数字转为金额 例：1000000.00 -> 1,000,000.00
      * 手机号码中间四位替换****
      * 移除首尾换行符
      * 身份证号码格式化 6-4-4-4格式
      * 银行卡格式化
      * 字符串转16进制
      * json转换
      * 汉字转拼音,每个汉字拼音中间空格隔开
      * 返回字符串第一个字母大写
      * 获取字符串字节长度
      * 根据字节截取字符串
      * 从html string获取图片url 数组
      * 修改html标签style
      * 获取一段可变字符串的属性字典
      * 32位MD5加密，无二次处理
      * 16位MD5加密，二次处理
      * 基于散列的消息认证码 HMAC-MD5加密
      * sha1加密方式
      * sha1加密再用base64处理
      * sha256加密方式
      * sha384加密方式
      * sha512加密方式
      * base64编码
      * base64解码
      * 转为16进制字符串
      * 十六进制转换为普通字符串
      * des 加密 key必须大于8字节
      * des 解密
      * 3des 加密 key必须大于24字节,否则加密失败，返回错误参数
      * 3des 解密
      * AES128 加密 key必须大于16字节,否则加密失败，返回错误参数
      * AES128 解密 key必须大于32字节,否则加密失败，返回错误参数
      * AES256 加密 (秘钥偏移量最少32)
      * AES256 解密
    * NSDictionary
      * 字典安全取值
      * 转成可变型数据，包括里面的字典、数组
      * 替换字典中的NSNull为空字符串
      * 合并两个字典
    * NSError
      * 生成自定义错误
    * NSBundle
      * 获取app应用名称
      * 获取 APP 应用版本
      * 获取BundleID
      * 获取编译版本
      * 当前应用版本是否需要更新
    * NSArray
      * 去除重复元素
      * 主键去重复，如果元素是字符串key可不传；如果元素是字典，则传主键
      * 替换数组中的NSNull为空字符串
      * 转成可变型数据，包括里面的字典、数组
