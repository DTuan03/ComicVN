# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'ComicVN' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ComicVN

pod 'SnapKit'
pod 'RxSwift'
pod 'RxCocoa'
pod 'FirebaseAuth'
pod 'IQKeyboardManagerSwift'
pod 'Cosmos'
pod 'RealmSwift'
pod 'DropDown'

 post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
end
