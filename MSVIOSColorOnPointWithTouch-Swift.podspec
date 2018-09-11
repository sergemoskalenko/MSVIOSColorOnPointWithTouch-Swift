#
# Be sure to run `pod lib lint MSVIOSColorOnPointWithTouch-Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MSVIOSColorOnPointWithTouch-Swift'
  s.version          = '0.1.1'
  s.summary          = 'MSVIOSColorOnPointWithTouch - color on touch of view, image from view, color of point at view for iOS development.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MSVIOSColorOnPointWithTouch - color on touch of view, image from view, color of point at view for iOS development. Have a nice day.
                       DESC

  s.homepage         = 'https://github.com/sergemoskalenko/MSVIOSColorOnPointWithTouch-Swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Serge Moskalenko' => 'camopu-ympo, http://camopu.rhorse.ru/ios' }
  s.source           = { :git => 'https://github.com/sergemoskalenko/MSVIOSColorOnPointWithTouch-Swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/sergemoskalenkoo>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MSVIOSColorOnPointWithTouch-Swift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MSVIOSColorOnPointWithTouch-Swift' => ['MSVIOSColorOnPointWithTouch-Swift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
 
 s.swift_version = '4.0'
end
