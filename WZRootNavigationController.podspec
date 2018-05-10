Pod::Spec.new do |s|
  s.name             = 'WZRootNavigationController'
  s.version          = '0.1.0'
  s.summary          = '独立导航栏，自定义转场动画，自定义Pop手势处理'
  s.homepage         = 'https://github.com/arcangelw/WZRootNavigationController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'arcangelw' => 'wuzhezmc@gmail.com' }
  s.source           = { :git => 'https://github.com/arcangelw/WZRootNavigationController.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'WZRootNavigationController/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
end
