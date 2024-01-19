Pod::Spec.new do |s|
  s.name                = "BuzzRxTest"
  s.version             = "6.6.0-rc.0"
  s.summary             = "BuzzRxTest is a Buzzvil's wrapper framework for RxTest"
  s.homepage            = "https://www.buzzvil.com"
  s.license             = 'MIT'
  s.author              = { "Buzzvil" => "dev@buzzvil.com" }
  s.source              = { :http => "https://github.com/Buzzvil/RxSwift/releases/download/v6.6.0-rc.0/BuzzRxTest.zip" }
  s.vendored_frameworks = 'BuzzRxTest.xcframework'

  s.requires_arc          = true

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '9.0'

  s.framework    = 'XCTest'

  s.dependency 'BuzzRxSwift', '6.6.0-rc.0'
  s.swift_version = '5.5'

  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
