//
//  Config.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 定义常量
 */

static const int minNum=  0;//定义输入数字最小值
static const int maxNum = 1000000;//定义输入数字最大值
static const int minStr = 2;//定义输入字符串最小值
static const int midStr = 50;//定义输入字符串中间值，适用标题
static const int maxStr = 5000;//定义输入字符串最小值，适用描述

@interface Config : UIView{
    
}


/*
 Base Config
 */

//App Name
#define AppName @"365平安校园"

//客户ID
#define CustomerID @"0"

//应用发布至App Store后的ID
#define AppID @""

//百度移动统计ID
#define BaiduMobStatID @"508c0f8740"
#define BaiduMobStatChannelID @"App Store"

//微信ID
#define WeiXinID @"wxd96e1c30888b5017"

//Parse网站推送信息ID
#define ParseAppID @"LjWSVsi9jYkFaewHF30ojPWImGc2RY9gPjBSLgJo"
#define ParseClientKey @"GTiuZQJYHBKStNMJNkBMgqf7vI1apTml60oMWdM6"

#define DefaultLat @"43.791099"
#define DefaultLng @"87.616736"
#define DefaultCity @"乌鲁木齐市"
#define DefaultAddress @"新疆乌鲁木齐市"
#define DefaultImage @"http://www.365paxy.org.cn/img/default_image.png"

#define DefaultNoData @"没有更多数据";

/*
 URL Config
 */

#define ParentMenu1Url @"http://html5.365paxy.org.cn/wiki/"
#define ParentMenu2Url @"http://html5.365paxy.org.cn/faq/"
#define ParentMenu3Url @"http://html5.365paxy.org.cn/expert/"
#define ParentMenu4Url @"http://html5.365paxy.org.cn/parentgroup/"

//获取问卷调查列表
#define QuestionListUrl @"http://api.365paxy.org.cn/api/QuestionList.aspx"
//获取新闻列表
#define NewsListUrl @"http://api.365paxy.org.cn/api/NewsList.aspx"
#define NewsListForNoticeUrl @"http://api.365paxy.org.cn/api/NewsListForNotice.aspx"
#define NewsListForSchoolUrl @"http://api.365paxy.org.cn/api/NewsListForSchool.aspx"
#define CancelFavoriteUrl @"http://api.365paxy.org.cn/api/CancelFavorite.aspx"
#define CheckFavoriteUrl @"http://api.365paxy.org.cn/api/CheckFavorite.aspx"
#define AddFavoriteUrl @"http://api.365paxy.org.cn/api/AddFavorite.aspx"

#define FavoriteNewsListUrl @"http://api.365paxy.org.cn/api/FavoriteNewsList.aspx"
//获取新闻列表
#define ViewNewsUrl @"http://html5.365paxy.org.cn/news/"
#define ViewQuestionUrl @"http://html5.365paxy.org.cn/question/"
#define WebsiteUrl @"http://www.365paxy.org.cn/"
#define PrivacyUrl @"http://www.365paxy.org.cn/app/privacy.htm"

//显示周边的，按照距离排序
#define WarningListUrl @"http://api.365paxy.org.cn/api/WarningList.aspx"
//优化显示我的，按照时间排序
#define WarningByMeListUrl @"http://api.365paxy.org.cn/api/WarningListForMe.aspx"
#define WarningAddUrl @"http://api.365paxy.org.cn/api/AddWarning.aspx"
#define WarningVisitUrl @"http://api.365paxy.org.cn/api/UpdateWarningVisit.aspx"
#define MessageListUrl @"http://api.365paxy.org.cn/api/MessageList.aspx"
#define WarningDelUrl @"http://api.365paxy.org.cn/api/DeleteWarning.aspx"

//获取用户信息
#define GetUserDetailsUrl @"http://api.365paxy.org.cn/api/GetUserDetails.aspx"
#define UsersByClassListUrl @"http://api.365paxy.org.cn/api/FindUsersByClass.aspx"
#define CheckUserUrl @"http://api.365paxy.org.cn/api/CheckUser.aspx"

//获取城市列表
#define CityListUrl @"http://api.365paxy.org.cn/api/CityList.aspx"
#define AreaListUrl @"http://api.365paxy.org.cn/api/AreaList.aspx"
#define SchoolListUrl @"http://api.365paxy.org.cn/api/SchoolList.aspx"
#define ClassListUrl @"http://api.365paxy.org.cn/api/ClassList.aspx"
#define CourseListUrl @"http://api.365paxy.org.cn/api/CourseList.aspx"
#define ContactsListUrl @"http://api.365paxy.org.cn/api/SelectContactsList.aspx"
#define FriendsListUrl @"http://api.365paxy.org.cn/api/FriendsList.aspx"
#define FriendsMyListUrl @"http://api.365paxy.org.cn/api/FriendsMyList.aspx"
//请假条类别
#define LeaveTypeListUrl @"http://api.365paxy.org.cn/api/LeaveTypeList.aspx"

//更新用户密码
#define UpdateUserPasswordUrl @"http://api.365paxy.org.cn/api/UpdateUserPassword.aspx"

//新增消息：家庭作业、成绩等
#define MessageAddUrl @"http://api.365paxy.org.cn/api/AddMessage.aspx"
//新增请假条
#define LeaveAddUrl @"http://api.365paxy.org.cn/api/AddLeave.aspx"
#define MessageCommentAddUrl @"http://api.365paxy.org.cn/api/GetComments.aspx"


#define CheckFriendUrl @"http://api.365paxy.org.cn/api/CheckFriends.aspx"
#define AddFriendUrl @"http://api.365paxy.org.cn/api/AddFriends.aspx"
#define ReviewFriendUrl @"http://api.365paxy.org.cn/api/ReviewFriends.aspx"

#define AddReviewUrl @"http://api.365paxy.org.cn/api/AddReview.aspx"
#define MessageDelUrl @"http://api.365paxy.org.cn/api/DeleteMessage.aspx"


//更新用户信息
#define UpdateUserInfoUrl @"http://api.365paxy.org.cn/api/UpdateUserInfo.aspx"
//更新孩子关系
#define UpdateChildUrl @"http://api.365paxy.org.cn/api/UpdateChild.aspx"
#define CountMessageNumUrl @"http://api.365paxy.org.cn/api/CountMessageNum.aspx"
#define AddBindUrl @"http://api.365paxy.org.cn/api/AddBind.aspx"
#define UpdateBindUrl @"http://api.365paxy.org.cn/api/UpdateBind.aspx"
//绑定关系
#define BindListUrl @"http://api.365paxy.org.cn/api/BindList.aspx"
#define DelBindUrl @"http://api.365paxy.org.cn/api/DeleteBind.aspx"


//用户登陆
#define LoginUrl @"http://api.365paxy.org.cn/API/GetUserLogin.aspx"
//用户注册
#define RegisterUrl @"http://api.365paxy.org.cn/api/GetRegister.aspx"
//商户注册
#define RegisterShopUrl @"http://api.365paxy.org.cn/api/GetShopRegister.aspx"

//获取商户信息
#define GetShopDetailsUrl @"http://api.365paxy.org.cn/api/GetShopDetails.aspx"
//获取地址列表
#define AddressListUrl @"http://api.365paxy.org.cn/api/AddressList.aspx"
//添加地址
#define AddAddressUrl @"http://api.365paxy.org.cn/api/AddAddress.aspx"
//获取发票列表
#define InvoiceListUrl @"http://api.365paxy.org.cn/api/InvoiceList.aspx"
//添加发票
#define AddInvoiceUrl @"http://api.365paxy.org.cn/api/AddInvoice.aspx"
//更新订单状态
#define UpdateOrderStatusUrl @"http://api.365paxy.org.cn/api/UpdateOrderStatus.aspx"
//更新订单状态
#define CheckOrderNumUrl @"http://api.365paxy.org.cn/api/CountOrderNum.aspx"

//获取订单状态
#define GetOrderStatusUrl @"http://api.365paxy.org.cn/api/GetOrderStatus.aspx"
//获取评论
#define CommentListUrl @"http://api.365paxy.org.cn/api/CommentsList.aspx"
#define AddCommentUrl @"http://api.365paxy.org.cn/api/GetComments.aspx"
#define DeleteCommentUrl @"http://api.365paxy.org.cn/api/DeleteComments.aspx"
#define CommentLoveUrl @"http://api.365paxy.org.cn/api/CommentLove.aspx"
//更新用户头像
#define UpdateUserHeadImageUrl @"http://api.365paxy.org.cn/api/UpdateUserImage.aspx"

//更新地址
#define UpdateAddressUrl @"http://api.365paxy.org.cn/api/UpdateAddress.aspx"
//删除地址
#define DeleteAddressUrl @"http://api.365paxy.org.cn/api/DeleteAddress.aspx"
//更新发票抬头
#define UpdateInvoiceUrl @"http://api.365paxy.org.cn/api/UpdateInvoice.aspx"

//获取菜品列表
#define ItemsListUrl @"http://api.365paxy.org.cn/api/ShopItemsList.aspx"
//获取主菜口味列表
#define TasteListUrl @"http://api.365paxy.org.cn/api/TasteList.aspx"
//获取广告列表
#define AdsListUrl @"http://api.365paxy.org.cn/api/AdsList.aspx"


//意见反馈
#define FeedbackShopUrl @"http://www.365paxy.org.cn/shopfeedback.aspx"








//获取用户积分
#define GetUserScoreUrl @"http://api.365paxy.org.cn/api/GetUserScore.aspx"
//获取用户红包积分
#define GetUserLuckyMoneyScoreUrl @"http://api.365paxy.org.cn/api/GetUserLuckyMoneyScore.aspx"
//获取商户积分
#define GetShopScoreUrl @"http://api.365paxy.org.cn/api/GetShopScore.aspx"
//商户兑取积分
#define GetShopCashUrl @"http://api.365paxy.org.cn/api/AddCash.aspx"
//用户充值积分
#define GetUserRechargeUrl @"http://api.365paxy.org.cn/api/AddRecharge.aspx"
//获取验证码
#define ValidateVode @"http://api.365paxy.org.cn/api/GetCode.aspx"
//找回密码获取验证码
#define PasswordValidateCode @"http://api.365paxy.org.cn/api/GetPasswordCode.aspx"
//获取验证码
#define ForgetPasswordUrl @"http://api.365paxy.org.cn/api/ForgetUserPasswordNew.aspx"
//更新用户距离
#define UpdateUserDistanceUrl @"http://api.365paxy.org.cn/api/UpdateUserDistance.aspx"
//获取商户列表
#define ShopListUrl @"http://api.365paxy.org.cn/api/ShopList.aspx"
//根据用户需求获取商户信息及报价
#define PriceListUrl @"http://api.365paxy.org.cn/api/PriceList.aspx"
//获取产品列表
#define ProductsListUrl @"http://api.365paxy.org.cn/api/ProductList.aspx"


//获取引导页面列表
#define GuideListUrl @"http://api.365paxy.org.cn/api/GuideList.aspx"

//获取商户菜品分类列表
#define ShopItemsCategoryListUrl @"http://api.365paxy.org.cn/api/ShopItemsCategory.aspx"

//删除用户发布的服务
#define DeleteServiceUrl @"http://api.365paxy.org.cn/api/DeleteService.aspx"
//删除商户发布的产品
#define DeleteProductsUrl @"http://api.365paxy.org.cn/api/DeleteProducts.aspx"
//删除商户发布的报价
#define DeletePriceUrl @"http://api.365paxy.org.cn/api/DeletePrice.aspx"
//获取商户的实时报价状态
#define GetPriceStatusUrl @"http://api.365paxy.org.cn/api/GetPriceStatus.aspx"
//获取消息
#define MessageListUrl @"http://api.365paxy.org.cn/api/MessageList.aspx"
//获取消息
#define MessageSearchListUrl @"http://api.365paxy.org.cn/api/MessageListForSearch.aspx"
//新增日志
#define AddLogUrl @"http://api.365paxy.org.cn/api/AddLog.aspx"
//新增订单
#define AddOrderUrl @"http://api.365paxy.org.cn/api/AddOrder.aspx"
//获取订单列表
#define OrderListUrl @"http://api.365paxy.org.cn/api/OrderList.aspx"

//获取兑现列表
#define CashListUrl @"http://api.365paxy.org.cn/api/CashList.aspx"
//更新红包状态
#define UpdateLuckyMoneyStatus @"http://api.365paxy.org.cn/api/UpdateLuckyMoneyStatus.aspx"
//获取充值列表
#define RechargeListUrl @"http://api.365paxy.org.cn/api/RechargeList.aspx"
//获取红包列表
#define LuckyMoneyListUrl @"http://api.365paxy.org.cn/api/LuckyMoneyList.aspx"
//新增用户服务
#define AddServiceUrl @"http://api.365paxy.org.cn/api/AddService.aspx"
//我发布的需求
#define MyServiceListUrl @"http://api.365paxy.org.cn/api/ServiceList.aspx"
//添加商户报价
#define AddServicePriceUrl @"http://api.365paxy.org.cn/api/AddServicePrice.aspx"
//操作商户报价中标或撤标
#define CheckServicePriceUrl @"http://api.365paxy.org.cn/api/CheckServicePrice.aspx"
//获取产品类别列表
#define ProductTypeListUrl @"http://api.365paxy.org.cn/api/ProductTypeList.aspx"
//商户发布产品
#define AddProductsUrl @"http://api.365paxy.org.cn/api/AddProducts.aspx"
//商户编辑产品
#define UpdateProductsUrl @"http://api.365paxy.org.cn/api/UpdateProduct.aspx"
//获取商户信息
#define GetShopDetailsUrl @"http://api.365paxy.org.cn/api/GetShopDetails.aspx"
//更新商户信息
#define UpdateShopDetailsUrl @"http://api.365paxy.org.cn/api/UpdateShopInfo.aspx"

//更新邮寄信息
#define UpdatePostInfoUrl @"http://api.365paxy.org.cn/api/UpdatePostInfo.aspx"
//更新支付信息
#define UpdateShopPayInfoUrl @"http://api.365paxy.org.cn/api/UpdateShopPayInfo.aspx"
//添加自定义订单
#define AddCustomOrdersUrl @"http://api.365paxy.org.cn/api/AddCustomOrders.aspx"
//获取自定义订单列表
#define CustomOrdersListUrl @"http://api.365paxy.org.cn/api/CustomOrdersList.aspx"

//添加收藏
#define AddFavoriteUrl @"http://api.365paxy.org.cn/api/AddFavorite.aspx"
//取消收藏
#define CancelFavoriteUrl @"http://api.365paxy.org.cn/api/CancelFavorite.aspx"
//检测是否收藏
#define CheckFavoriteUrl @"http://api.365paxy.org.cn/api/CheckFavorite.aspx"
//获取收藏商户列表
#define FavoriteShopUrl @"http://api.365paxy.org.cn/api/FavoriteShopList.aspx"
//删除收藏
#define DelFavoriteNewsUrl @"http://api.365paxy.org.cn/api/AddFavorite.aspx"


//上图图片
#define UploadImageUrl @"http://api.365paxy.org.cn/api/uploadimage.aspx"

//意见反馈
#define FeedbackUrl @"http://api.365paxy.org.cn/api/feedback.aspx"

//更新消息状态
#define UpdateMessageStatusUrl @"http://api.365paxy.org.cn/api/UpdateMessageStatus.aspx"
//统计最新消息数量
#define CountMessageUrl @"http://api.365paxy.org.cn/api/CountMessageNum.aspx"
//统计未读得服务数量
#define CountUnReadServiceNumUrl @"http://api.365paxy.org.cn/api/CountServiceUnReadNum.aspx"

//获取车列表
#define MotoTypeListUrl @"http://api.365paxy.org.cn/api/MotoTypeList.aspx"

//添加阅读记录
#define AddReadServiceLogUrl @"http://api.365paxy.org.cn/api/AddServiceLog.aspx"
//获取参数设置
#define GetSetUrl @"http://api.365paxy.org.cn/api/GetSet.aspx"




//获取积分日志
#define ScoreLogListUrl @"http://api.365paxy.org.cn/api/GetScoreLog.aspx"

//新增位置信息
#define AddLocationUrl @"http://api.365paxy.org.cn/api/GetLocation.aspx"

//更新推送消息访问量
#define UpdateNewsUrl @"http://api.365paxy.org.cn/api/UpdateVisitNum.aspx"

//新增积分
#define AddScoreUrl @"http://api.365paxy.org.cn/api/AddScore.aspx"



//客户服务
#define ServiceUrl @"http://www.365paxy.org.cn/service/"
//在线问答
#define FAQUrl @"http://www.365paxy.org.cn/faq/"
//关于我们
#define APPUrl @"http://www.365paxy.org.cn/about/"

//分享
#define ShareAppName @"365平安校园"
#define ShareAppURL @"http://www.365paxy.org.cn/down/"
#define ShareAppTitle @"365平安校园"
#define ShareAppContent @"365平安校园"


@end
