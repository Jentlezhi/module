#
# Be sure to run `pod lib lint FunctionModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FunctionModuleLib'
  s.version          = '0.0.1'
  s.summary          = '功能组件-二进制化.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
功能组件：常用控件、下载、加载图片等.
                       DESC

  s.homepage         = 'https://gitee.com/jentle_095/FunctionModuleLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jentlezhi' => 'juntaozhi@163.com' }
  s.source           = { :git => 'https://gitee.com/jentle_095/FunctionModuleLib.git', :tag => '0.0.1' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Headers/**/*.h'
  s.vendored_frameworks = 'Products/FunctionModuleLib.framework'

  
  # s.resource_bundles = {
  #   'FunctionModule' => ['FunctionModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
