# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Golyv Task' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Golyv Task
    pod 'RxSwift'
    pod 'RxCocoa'
  
  target 'Golyv TaskTests' do
    inherit! :search_paths
    # Pods for testing
      pod 'RxSwift'
      pod 'RxCocoa'
  end

  target 'Golyv TaskUITests' do
    # Pods for testing
  end

end
post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
		end
	end
end