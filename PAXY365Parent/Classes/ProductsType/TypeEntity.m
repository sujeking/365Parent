//
//  TypeEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "TypeEntity.h"

@implementation TypeEntity
@synthesize TypeID;
@synthesize TypeName;
@synthesize ParentID;

-(void) dealloc
{
    self.TypeName = nil;
    self.TypeID = nil;
    self.ParentID = nil;
    
    [super dealloc];
}

@end
