//
//  Tool.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "Tool.h"

@implementation Tool

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
 * 更多详情，请参考此页面
 * http://blog.csdn.net/chaoyuan899/article/details/38583759
 */



+ (BOOL)isMobilePhone:(NSString *)value
{
    BOOL bValue = FALSE;
    
    NSString *getFirstWord = nil;
    if (value.length>1) {
        getFirstWord = [value substringToIndex:1];
    }
    
    NSString *regex = @"(^[0-9]{8,9}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    bValue = [pred evaluateWithObject:value];
    
    
    if ([getFirstWord isEqualToString:@"0"] || [getFirstWord isEqualToString:@"1"]|| [getFirstWord isEqualToString:@"4"]|| [getFirstWord isEqualToString:@"7"]) {
        bValue = FALSE;
    }
    
    return bValue;
}

/*
 *验证昵称，由2~25个字符组成，字母，数字，下划线
 */
+ (BOOL)isNickName:(NSString *)value
{
    NSString *      regex = @"([\u4e00-\u9fa5_a-zA-Z0-9_]{2,25}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:value];
}

+ (BOOL)isRealName:(NSString *)value
{
    NSString *      regex = @"([\u4e00-\u9fa5_a-zA-Z0-9_]{2,20}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:value];
}

+ (BOOL)isKeyword:(NSString *)value
{
    NSString *      regex = @"([\u4e00-\u9fa5_a-zA-Z0-9_]{1,20}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:value];
}


+ (BOOL)isAddress:(NSString *)value
{
    NSString *      regex = @"([\u4e00-\u9fa5_a-zA-Z0-9_]{4,50}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:value];
}

+ (BOOL)isUserName:(NSString *)value
{
    NSString *      regex = @"(^[A-Za-z0-9]{4,20}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:value];
}

+ (BOOL)isPassword:(NSString *)value
{
    NSString *      regex = @"(^[A-Za-z0-9]{4,20}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:value];
}

+ (BOOL)isEmail:(NSString *)value
{
    NSString *      regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:value];
}

+ (BOOL)isUrl:(NSString *)value
{
    NSString *      regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:value];
}

+ (BOOL)isTelephone:(NSString *)value
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:value]   ||
    [regextestphs evaluateWithObject:value]      ||
    [regextestct evaluateWithObject:value]       ||
    [regextestcu evaluateWithObject:value]       ||
    [regextestcm evaluateWithObject:value];
}


//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)value
{
    NSScanner* scan = [NSScanner scannerWithString:value];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)value
{
    NSScanner* scan = [NSScanner scannerWithString:value];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


@end
