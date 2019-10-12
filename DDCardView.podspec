#
# Be sure to run `pod lib lint WriteFileSupportSpec.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDCardView'
  s.version          = '1.0.1'
  s.summary          = 'iOS DeviceInfo'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/DDstrongman/DDCardView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DDStrongman' => 'lishengshu232@gmail.com' }
  s.source           = { :git => 'https://github.com/DDstrongman/DDCardView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'DDCardView/Classes/**/*' 
  s.resource_bundles = {
    'DDCardViewSpec' => ['DDCardView/Assets/*.png']
  }
  s.dependency 'SDWebImage'
#s.frameworks = 'sys', 'arpa', 'Foundation', 'ifaddrs'

end
