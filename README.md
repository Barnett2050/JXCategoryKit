## JXCategoryKit  系统基础类扩展
* 包含 Foundation.framework 内的NSArray，NSBundle，NSData，NSDate，NSDictionary，NSError，NSFileManager，NSNotificationCenter，NSNull，NSObject，NSString， NSTimer相关类扩展方法
* 包含 UIKit.framework内的UIApplication，UIButton，UIColor，UIControl，UIDevice，UIGestureRecognizer，UIImage，UIScrollView，UITabBarController，UITableView，UITableViewCell，UITextField，UIView，UIViewController，UIWindow相关类扩展方法
* 包含 CoreLocation.framework内的CLLocation 类扩展
* 包含 QuartzCore.framework 的CALayer 类扩展

📜提示：所有类扩展方法均是整理总结的自定义方法，并且方法名均以 jx_ 开头，避免了与其它类扩展自定义方法名冲突。        
Hook系统方法的类有如下：            
UIButton：Hook了sendAction方法，并引出了在sendAction之前的一个实例方法。
NSArray：Hook了系统方法，安全取值。
NSMutableArray：Hook了系统方法，安全取值，插入，删除等。
NSMutableDictionary：Hook了系统方法，安全赋值。
NSString：Hook了系统方法，安全取值。
NSMutableString：Hook了系统方法，安全取值，插入，删除。

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
    * UIApplication
        * 通知是否启用
        * 跳转App系统通知设置
        * 注册通知
    * UIButton
        * 设置自定义图片文字位置按钮
        * 开始加载菊花动画
    * UIColor
        * iOS 13.0 亮暗颜色设置
        * 传入十进制颜色生成UIColor
        * 十六进制字符串和颜色互相转换
        * HSL颜色转换
        * CMYK颜色转换
    * UIControl
        * 从内部调度表中删除所有目标和操作。
        * 将特定事件（或多个事件）的目标和操作 添加或替换 到内部调度表中。
        * 将一个或多个特定事件的块添加到内部调度表中。
        * 将特定事件（或多个事件）的块添加或替换到内部调度表中。
        * 从内部调度表中删除特定事件（或多个事件）的所有block。
    * UIDevice
        * 获取通用 - 关于本机 - 名称
        * 获取设备类型
        * 获取系统名称 iOS
        * 获取设备系统版本 13.3/12.0
        * 获取设备电量
        * 获取手机本地语言 zh-Hans-CN/en
        * 获取 WiFi 信号强度，只有在WiFi显示时才能获取到
        * 获取设备名称，例：iPhone 11 Pro Max
        * 获取IDFA
        * 获取IDFV
        * 获取UUID
        * 获取当前设备磁盘总容量(单位：MB）
        * 获取当前设备磁盘剩余容量(单位：MB）
        * 获取当前设备磁盘使用容量(单位：MB）
        * 获取当前设备全部系统内存(单位：MB）
        * 获取当前设备使用系统内存(单位：MB）
        * 获取当前设备剩余系统内存(单位：MB）
        * 当前线程占用内存（字节为单位）,（发生错误时为-1）
    * UIGestureRecognizer
        * block初始化手势
        * block添加到手势识别器
        * 移除所有的手势block
    * UIImage
        * 裁剪图片中的一块区域
        * 图片裁剪，圆角，边框等
        * 拉伸图片
        * 改变图片尺寸
        * 图片模糊处理，高亮，自定义等
        * 更新图片的方向，直立显示
        * 转换图片为png格式的base64编码
        * 拼接长图
        * 根据图片url获取网络图片尺寸
        * 压缩图片
        * GIF数据图
        * PDF文件返回第一张图
        * 返回一个旋转图像
        * 生成带圆角的颜色图片
        * 生成矩形的颜色图片
        * 生成渐变色的UIImage
        * 生成三角图片
        * 从苹果表情符号创建图像
        * 图像绘制block
        * 生成二维码
        * 获取二维码内内容
    * UIScrollView
        * 滚动到顶部
        * 滚动到底部
        * 滚动到左 
        * 滚动到右 
    * UITabBarController
        * 设置导航栏背景颜色和阴影颜色
        * 设置tabbar背景颜色和阴影颜色
        * 设置tabbar 文字normal颜色和selected颜色
        * tabbar动态显示和隐藏
    * UITableView
        * tableView更新block，例如insert, delete, 或者 select
        * 取消tableView所有行的选中 
    * UITableViewCell
        * 显示缩放效果
        * 显示缩进效果
        * 显示旋转效果
        * 设置分割线左边距,右边距
    * UITextField
        * 当前输入是否高亮 true 高亮 false 无高亮
        * 选中所有文本
        * 设定选中文本
    * UIView
        * 添加圆角，适用于自动布局，传入设置frame
        * 添加圆角,适用于已知frame，即非自动布局
        * 添加圆角，适用于已知frame，即非自动布局，圆角位置为UIRectCornerAllCorners
        * 添加圆角，适用于自动布局，传入设置frame，圆角位置为UIRectCornerAllCorners
        * 绘制虚线
        * x，y，width，height，centerX，centerY，size，origin，maxX，maxY
        * 屏幕快照
        * 屏幕快照生成pdf
        * 截取 view 上某个位置的图像
        * 毛玻璃效果
        * 添加Tap，Pan，LongPress手势
    * UIViewController
        * Alert系统提示
        * AlertSheet系统提示
        * 设置系统标题颜色和字体
        * 设置系统状态栏背景颜色
        * 返回按钮点击事件
        * 隐藏返回按钮
    * UIWindow
        * 获取主窗体 UIWindow
        * 导航栈的栈顶视图控制器
        * 获取当前显示的控制器

* Foundation
    * NSArray
        * 去除重复元素
        * 主键去重复，如果元素是字符串key可不传；如果元素是字典，则传主键
        * 替换数组中的NSNull为空字符串
        * 转成可变型数据，包括里面的字典、数组
        * 数组的安全取值
        * 数组与plist数据转换，数组反转
    * NSBundle
        * 获取app应用名称
        * 获取 APP 应用版本
        * 获取BundleID
        * 获取编译版本
        * 当前应用版本是否需要更新
    * NSData
        * hash加密，包括MD2,MD5,shaX,HMAC-xxxx等
        * 多种非对称加密，base64处理
        * gzip压缩和解压缩
        * zlib压缩和解压缩
    * NSDate
        * 根据日期格式获取系统时间
        * 根据日期格式时间字符串转NSDate
        * 根据日期格式转化时间戳(UTC)
        * 根据日期格式转化时间戳字符串(UTC)
        * 根据日期格式转化时间字符串为时间戳(UTC)
        * 时间戳转n小时、分钟、秒前 或者yyyy-MM-dd HH:mm:ss
        * 将秒根据格式转换，限于时分秒
        * 时间戳根据格式返回数据 HH:mm、昨天 HH:mm、MM月dd日 HH:mm、yyyy年MM月dd日)
        * 根据日期格式Date转时间字符串
        * 时间戳UTC转换为本地时间，例：几分钟前，几小时前，几天前，几月前，几年前
        * 日期时间对比，今天，昨天，年月日时分秒
    * NSDictionary
        * 字典安全取值
        * 转成可变型数据，包括里面的字典、数组
        * 替换字典中的NSNull为空字符串
        * 合并两个字典
        * 字典与plist数据转换
    * NSError
        * 生成自定义错误
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
    * NSNotificationCenter
        * 在主线程上向接收者发送给定的通知。如果当前线程是主线程，则通知被同步发送；否则，被异步发送。
        * 在主线程上将通知发送给接收者。
        * 创建具有给定名称和发送方的通知，并将其发布到主线程上的接收方。 如果当前线程是主线程，则通知被同步发布； 否则，将被异步发布。
        * 创建具有给定名称和发送方的通知，并将其发布到主线程上的接收方。 如果当前线程是主线程，则通知被同步发布； 否则，将被异步发布。
        * 创建具有给定名称和发送方的通知，并将其发布到主线程上的接收方。 如果当前线程是主线程，则通知被同步发布； 否则，将被异步发布。
    * NSNull
        * nil空对象方法调用时安全处理
    * NSObject
        * swizzle交换类方法
        * swizzle交换类实例方法
        * 判断方法是否在子类里override了
        * 判断当前类是否在主bundle里
        * 输出类方法
        * 输出类属性
        * 返回类属性字典
        * kvo使用block实现
        * 清空所有属性值
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
        * 非对称加密
    * NSTimer
        * 快速创建timer
        * 暂停Timer
        * 恢复Timer
        * 过一段时间继续Timer


    




