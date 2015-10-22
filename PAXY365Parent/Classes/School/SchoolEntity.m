//
//  SchoolEntity.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "SchoolEntity.h"

@implementation SchoolEntity
@synthesize SchoolID;
@synthesize SchoolName;


-(void) dealloc
{
    self.SchoolID = nil;
    self.SchoolName = nil;
    
    [super dealloc];
}

@end
