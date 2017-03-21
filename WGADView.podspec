
Pod::Spec.new do |s|

  s.name         = "WGADView"
  s.version      = "0.0.1"
  s.summary      = "启动图广告页面"

  s.homepage     = "https://github.com/SoftBoys/WGADView"

  s.license      = "MIT"

  s.author       = { "SoftBoys" => "gjw_1991@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/SoftBoys/WGADView.git", :tag => "#{s.version}" }

  s.source_files  = "ADViewDemo/ADView/*.{h,m}"

  s.requires_arc = true

  s.dependency 'SDWebImage'

end
