//
//  Tool.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tool : UIView

+ (BOOL)isMobilePhone:(NSString *)value;
+ (BOOL)isNickName:(NSString *)value;
+ (BOOL)isRealName:(NSString *)value;
+ (BOOL)isKeyword:(NSString *)value;
+ (BOOL)isUserName:(NSString *)value;
+ (BOOL)isPassword:(NSString *)value;
+ (BOOL)isEmail:(NSString *)value;
+ (BOOL)isUrl:(NSString *)value;
+ (BOOL)isTelephone:(NSString *)value;
+ (BOOL)isPureInt:(NSString*)value;
+ (BOOL)isPureFloat:(NSString*)value;
+ (BOOL)isAddress:(NSString *)value;

@end
