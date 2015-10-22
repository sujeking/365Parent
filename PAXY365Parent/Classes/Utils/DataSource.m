//
//  DataSource.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "DataSource.h"
#import "JSON.h"
@implementation DataSource

+(NSDictionary *)fetchJSON : (NSString *)text
{      
    NSString *urlString = [[NSString alloc] initWithString:text];
    NSURL *url= [[NSURL alloc] initWithString:urlString];
    
    return [self fetchJSONValueForURL:url];
}

+(id)fetchJSONValueForURL : (NSURL *)url
{
    NSString *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    id jsonValue = [jsonString JSONValue];
    return  jsonValue;
}

+(NSString *)DataToJson : (NSDictionary *) data
{
    return [data JSONRepresentation];
}


@end
