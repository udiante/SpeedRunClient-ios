# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
inhibit_all_warnings!
use_frameworks!

def basePods
    pod 'Alamofire', '~> 4.7'
    pod 'SDWebImage', '~> 4.0'
end

target 'SpeedRunClientPRO' do
    basePods
end

target 'SpeedRunClient' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  basePods
  pod 'Mockingjay'

  target 'SpeedRunClientTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SpeedRunClientUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
