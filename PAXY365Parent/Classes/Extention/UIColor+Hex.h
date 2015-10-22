//
//  UIColor+Hex.h
//  PAXY365Parent
//
//  Created by lan on 15/10/3.
//  Copyright © 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/** 根据16进制字符串设置颜色 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/** 根据16进制字符串设置颜色 */
+ (UIColor *)colorWithHexString:(NSString *)color;


@end
