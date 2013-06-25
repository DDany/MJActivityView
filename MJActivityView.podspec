Pod::Spec.new do |s|
  s.name         = "MJActivityView"
  s.version      = "0.0.1"
  s.summary      = "A way to show view in action sheet-style, and much more better."
  s.homepage     = "https://github.com/DDany"
  s.license 	 = 'LICENSE'
  s.author       = { "Dany" => "Dany" }
  s.source       = { :git => "https://github.com/DDany/MJActivityView.git", :commit => 'ead68b4b4012186d6123438ae4297ee3a16b6e22' }
  s.platform     = :ios, '5.0'
  s.source_files = 'MJActivityView.h', 'MJActivityView.m'
  s.framework  = 'CoreGraphics'
  s.requires_arc = true
end
