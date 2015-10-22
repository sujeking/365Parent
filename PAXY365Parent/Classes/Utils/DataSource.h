//
//  DataSource.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

+(NSDictionary *)fetchJSON : (NSString *)text;
+(id)fetchJSONValueForURL : (NSURL *)url;
+(NSString *)DataToJson : (NSDictionary *) data;

@end
