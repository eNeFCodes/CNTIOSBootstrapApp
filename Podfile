# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CNTIOSBootstrapApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CNTIOSBootstrapApp
  #pod 'SwiftGen', '~> 6.5.1'
  pod 'R.swift', '~> 6.1.0'

  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = "NO"
      config.build_settings['GCC_WARN_TYPECHECK_CALLS_TO_PRINTF'] = "NO"
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = "-Owholemodule"
      config.build_settings['GCC_WARN_64_TO_32_BIT_CONVERSION'] = "NO"
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
