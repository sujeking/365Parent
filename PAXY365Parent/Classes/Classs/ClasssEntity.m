//
//  ClasssEntity.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ClasssEntity.h"

@implementation ClasssEntity
@synthesize ClassID;
@synthesize ClassName;


-(void) dealloc
{
    self.ClassID = nil;
    self.ClassName = nil;
    
    [super dealloc];
}

@end
