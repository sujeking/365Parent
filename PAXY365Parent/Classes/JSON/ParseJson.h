//
//  ParseJson.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "ShopEntity.h"
#import "ProductsEntity.h"
#import "CommentEntity.h"
#import "OrderEntity.h"
#import "ServiceEntity.h"
#import "TypeEntity.h"
#import "MessageEntity.h"

#import "CashEntity.h"
#import "RechargeEntity.h"
#import "MotoTypeEntity.h"
#import "LuckyMoneyEntity.h"
#import "CustomOrderEntity.h"
#import "MenusEntity.h"
#import "AddressEntity.h"
#import "InvoiceEntity.h"
#import "TasteEntity.h"

#import "QuestionEntity.h"
#import "NewsEntity.h"
#import "WarningEntity.h"
#import "MessageEntity.h"
#import "AreaEntity.h"
#import "CityEntity.h"
#import "SchoolEntity.h"
#import "ClasssEntity.h"
#import "CourseEntity.h"
#import "ContactsEntity.h"
#import "BindEntity.h"

#import "WSNet.h"
#import "JSON.h"

@interface ParseJson : WSNet{
    
}

+(NSMutableArray *) getQuestionList:(NSDictionary *) dic;
+(NSMutableArray *) getNewsList:(NSDictionary *) dic;
+(NSMutableArray *) getWarningList:(NSDictionary *) dic;
+(NSMutableArray *) getMessageList:(NSDictionary *) dic;
+(NSMutableArray *) getAreaList:(NSDictionary *) dic;
+(NSMutableArray *) getSchoolList:(NSDictionary *) dic;
+(NSMutableArray *) getClassList:(NSDictionary *) dic;
+(NSMutableArray *) getCourseList:(NSDictionary *) dic;
+(NSMutableArray *) getCommentsList:(NSDictionary *) dic;
+(NSMutableArray *) getContactsList:(NSDictionary *) dic;
+(NSMutableArray *) getBindList:(NSDictionary *) dic;

/*old*/

+(NSMutableArray *) getShopList:(NSDictionary *) dic;
+(NSMutableArray *) getMenusList:(NSDictionary *) dic;
+(NSMutableArray *) getProductsList:(NSDictionary *) dic;

+(NSMutableArray *) getOrdersList:(NSDictionary *) dic;
+(NSMutableArray *) getAddressList:(NSDictionary *) dic;
+(NSMutableArray *) getInvoiceList:(NSDictionary *) dic;
+(NSMutableArray *) getTasteList:(NSDictionary *) dic;


+(NSMutableArray *) getServiceList:(NSDictionary *) dic;
+(NSMutableArray *) getTypeList:(NSDictionary *) dic;
+(NSMutableArray *) getMessageList:(NSDictionary *) dic;
+(NSMutableArray *) getCityList:(NSDictionary *) dic;
+(NSMutableArray *) getCashList:(NSDictionary *) dic;
+(NSMutableArray *) getRechargeList:(NSDictionary *) dic;
+(NSMutableArray *) getMotoTypeList:(NSDictionary *) dic;
+(NSMutableArray *) getLuckyMoneyList:(NSDictionary *) dic;
+(NSMutableArray *) getCustomOrderList:(NSDictionary *) dic;

@end
