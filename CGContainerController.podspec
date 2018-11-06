#
# Be sure to run `pod lib lint CGContainerController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CGContainerController'
  s.version          = '0.1.0'
  s.summary          = 'CGContainerController'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A reusable page container similar to TopBuzz home page (一个类似于今日头条首页的可以复用的页面容器)
                       DESC

  s.homepage         = 'https://github.com/CodeGeekXu/CGContainerController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CodeGeekXu' => 'codegeekxu@gmail.com' }
  s.source           = { :git => 'https://github.com/CodeGeekXu/CGContainerController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CGContainerController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CGContainerController' => ['CGContainerController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'CGSegmentBar'
  s.dependency 'Masonry'
  
end
