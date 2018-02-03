# 设置支持最低平台
platform :ios, '8.0'

target ‘SwiftTest’ do
  # 如果是Swift项目,需添加"use_frameworks!"
  use_frameworks!

# Explicitly include Yoga if you are using RN >= 0.42.0
pod 'yoga' , :path => './node_modules/react-native/ReactCommon/yoga'
pod 'React', :path => './node_modules/react-native', :subspecs => [
  'Core',
  'BatchedBridge', #要加上
  'CxxBridge',  #要加上
  'DevSupport',  #要加上
  'tvOS',  #暂定
  'fishhook',  #要加上
  'ART',
  'RCTActionSheet',
  'RCTGeolocation',
  'RCTImage',
  'RCTNetwork',
  'RCTPushNotification',
  'RCTSettings',
  'RCTText',
  'RCTVibration',
  'RCTWebSocket'
]
# Third party deps podspec link
pod 'DoubleConversion', :podspec => './node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
pod 'GLog', :podspec => './node_modules/react-native/third-party-podspecs/GLog.podspec'
pod 'Folly', :podspec => './node_modules/react-native/third-party-podspecs/Folly.podspec'

pod 'SwiftyJSON'  #JSon解析
pod 'Alamofire', '~> 4.4'  #网络请求
pod 'AlamofireImage', '~> 3.1'  #网络请求对图片的封装  包含image的扩展、上传、缓存、样式等
pod 'SnapKit', '~> 3.2.0'  #代码布局适配
pod 'LLCycleScrollView'   #轮播图
pod 'TBEmptyDataSet'  #可以显示空的UITableView或者UICollectionView
pod 'DGElasticPullToRefresh'  #刷新组件
pod 'PKHUD', '~> 4.0'  #HUD
pod 'SwiftyUserDefaults'  #缓存
pod 'SKPhotoBrowser', '~> 4.0.0' #图片浏览器
pod 'IQKeyboardManagerSwift' #键盘遮挡
pod 'Gallery', '~> 1.3.0' #图片选择器
pod 'AMap3DMap' #高德3D地图
pod 'AMapLocation' #高德定位
pod 'AMapSearch' #高德地图搜索功能


end


# 删除yoga里面异常的两个.h文件的引入
def remove_unused_yoga_headers
    filepath = './Pods/Target Support Files/yoga/yoga-umbrella.h'

    contents = []

    file = File.open(filepath, 'r')
    file.each_line do | line |
        contents << line
    end
    file.close

    contents.delete_at(14) # #import "YGNodePrint.h"
    contents.delete_at(14) # #import "Yoga-internal.h"

    file = File.open(filepath, 'w') do |f|
        f.puts(contents)
    end
end

post_install do | installer |
    remove_unused_yoga_headers
end

