//
//  CityEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "CityEntity.h"

@implementation CityEntity
@synthesize cityId;
@synthesize cityName;


-(void) dealloc
{
    self.cityId = nil;
    self.cityName = nil;
    
    [super dealloc];
}

@end
