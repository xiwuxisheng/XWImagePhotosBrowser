#
# Be sure to run `pod lib lint XWImagePhotosBrowser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'XWImagePhotosBrowser'
    s.version          = '0.1.0'
    s.summary          = '仿微信图片浏览器.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    1.支持图片缩放拉伸及手势操作
    2.支持图片仿微信位置变换的动画
    3.通过协议扩展图片显示数据，本地和网络都可
    4.加入图片默认图更改及文字描述.
    DESC
    
    s.homepage         = 'https://github.com/xiwuxisheng/XWImagePhotosBrowser'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'xiwuxisheng' => 'xiw@addcn.com' }
    s.source           = { :git => 'https://github.com/xiwuxisheng/XWImagePhotosBrowser.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    s.source_files = 'XWImagePhotosBrowser/Classes/Controller/*','XWImagePhotosBrowser/Classes/View/*'
    s.subspec 'Common' do |cs|
        cs.source_files = 'XWImagePhotosBrowser/Classes/Common/*.{h,m}'
    end
    s.subspec 'Protocol' do |cs|
        cs.source_files = 'XWImagePhotosBrowser/Classes/Protocol/*.{h,m}'
    end
    
    s.resource_bundles = {
        'XWImagePhotosBrowser' => ['XWImagePhotosBrowser/Assets/Resource/*.png']
    }
    
    s.frameworks = 'UIKit', 'Foundation'
    s.dependency 'SDWebImage', '~> 4.4.2'
    s.dependency 'Masonry', '~> 1.1.0'
end
