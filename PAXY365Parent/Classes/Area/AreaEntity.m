//
//  AreaEntity.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "AreaEntity.h"

@implementation AreaEntity
@synthesize AreaID;
@synthesize AreaName;


-(void) dealloc
{
    self.AreaID = nil;
    self.AreaName = nil;
    
    [super dealloc];
}

@end
