
Pod::Spec.new do |s|
  s.name             = 'JXCategoryKit'
  s.version          = '0.1.2'
  s.summary          = '基础类扩展'
  s.homepage         = 'https://github.com/Barnett2050/JXCategoryKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zjx_mywork@163.com' => 'zjx_mywork@163.com' }
  s.source           = { :git => 'https://github.com/Barnett2050/JXCategoryKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  
  s.source_files = 'JXCategoryKit/JXCategoryKit.h'
  s.public_header_files = 'JXCategoryKit/JXCategoryKit.h'
  
  s.subspec 'CoreLocation' do |ss|
    ss.source_files = 'JXCategoryKit/CoreLocation/*.{h,m}'
    ss.public_header_files = 'JXCategoryKit/CoreLocation/*.h'
  end
  
  s.subspec 'QuartzCore' do |ss|
    ss.source_files = 'JXCategoryKit/QuartzCore/*.{h,m}'
    ss.public_header_files = 'JXCategoryKit/QuartzCore/*.h'
  end
  
  s.subspec 'UIKit' do |ss|
    ss.subspec 'UIWindow' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UIWindow/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UIWindow/*.h'
    end
    ss.subspec 'UIViewController' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UIViewController/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UIViewController/*.h'
    end
    ss.subspec 'UIView' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UIView/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UIView/*.h'
    end
    ss.subspec 'UITextField' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UITextField/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UITextField/*.h'
    end
    ss.subspec 'UITableViewCell' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UITableViewCell/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UITableViewCell/*.h'
    end
    ss.subspec 'UIImage' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UIImage/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UIImage/*.h'
    end
    ss.subspec 'UIDevice' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UIDevice/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UIDevice/*.h'
    end
    ss.subspec 'UIColor' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UIColor/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UIColor/*.h'
    end
    ss.subspec 'UIButton' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UIButton/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UIButton/*.h'
    end
    ss.subspec 'UITabBarController' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UITabBarController/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UITabBarController/*.h'
      
      sss.dependency 'JXCategoryKit/UIKit/UIImage'
    end
    ss.subspec 'UIApplication' do |sss|
      sss.source_files = 'JXCategoryKit/UIKit/UIApplication/*.{h,m}'
      sss.public_header_files = 'JXCategoryKit/UIKit/UIApplication/*.h'
    end
  end
  
  s.frameworks = 'UIKit', 'CoreLocation','Accelerate','UserNotifications','AdSupport'
  
end
