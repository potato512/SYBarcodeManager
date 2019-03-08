Pod::Spec.new do |s|

  s.name         = "SYBarcodeManager"
  s.version      = "2.1.8"
  s.summary      = "SYBarcodeManager is Qr code scanning tool."
  s.homepage     = "https://github.com/potato512/SYBarcodeManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "herman" => "zhangsy757@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/potato512/SYBarcodeManager.git", :tag => "#{s.version}" }
  s.source_files  = "SYBarcodeManager/**/*.{h,m}"
  s.resources    = "SYBarcodeManager/*.png"
  s.framework    = "AVFoundation"
  s.requires_arc = true

end
