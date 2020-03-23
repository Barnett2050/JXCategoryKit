
Pod::Spec.new do |s|
  s.name             = 'JXCategoryKit'
  s.version          = '0.1.0'
  s.summary          = '基础类扩展'
  s.homepage         = 'https://github.com/Barnett2050/JXCategoryKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zjx_mywork@163.com' => 'zjx_mywork@163.com' }
  s.source           = { :git => 'https://github.com/Barnett2050/JXCategoryKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  
  s.source_files = 'JXCategoryKit/JXCategoryKit.h'
  s.public_header_files = 'JXCategoryKit/JXCategoryKit.h'
  
  s.subspec 'CoreLocation' do |ss|
    ss.source_files = 'JXCategoryKit/CoreLocation/*.m'
    ss.public_header_files = 'JXCategoryKit/CoreLocation/*.h'
  end
  
  
  s.frameworks = 'UIKit', 'CoreLocation'
end
