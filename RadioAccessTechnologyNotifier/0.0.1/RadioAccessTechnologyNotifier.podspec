Pod::Spec.new do |s|
  s.name             = 'RadioAccessTechnologyNotifier'
  s.version          = '0.0.1'
  s.summary          = 'Network state change notifier'
 
  s.description      = <<-DESC
Detect if network is on Wifi, LTE, 3G or Edge
                       DESC
 
  s.homepage         = 'https://github.com/ioramashvili/RadioAccessTechnologyNotifier'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shota ioramashvili' => 'shotaioramashvili@gmail.com' }
  s.source           = { :git => 'https://github.com/ioramashvili/RadioAccessTechnologyNotifier.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'RadioAccessTechnologyNotifier/RadioAccessTechnologyNotifier.swift', 'RadioAccessTechnologyNotifier/Reachability.swift'
 
end