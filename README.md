# 家政C端Swift版

## 项目结构  <br>

	SwiftTest
	  |---Section				        视图文件目录，该目录下按照业务场景划分目录
	  |---Resource				        资源文件目录，如图片
	  |---Vendors				        存放第三方的插件
	  |---Helper				        工具类
	  	  |---Tools				        基础工具类
	  	  |---NetWord				        网络相关工具类
	  |---General				        通用类
	  	  |---Extension				        拓展类，比如对UIView、UIColor、UIButton进行扩展
	  	  |---Classes				        对视图控制器进行封装，所有子视图都应继承当前目录下对应的视图控制器，比如UIViewController、UINavigationControoler
	  	  |---Views				        自定义的一些公共的视图类组件，方便在项目多个地方使用
	  |---Macro				        宏
	  |---AppDelegate				        appdelegate文件
	  		 


## 项目视图分为四个模块
#### 首页
- 轮播图
- 商品类目
- 快速下单
- 套餐卡
- 储值卡
- 好友砍价
- 附近门店
#### 订单
#### 门店
#### 我的
