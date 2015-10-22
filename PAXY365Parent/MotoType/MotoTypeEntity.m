//
//  MotoTypeEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MotoTypeEntity.h"

@implementation MotoTypeEntity
@synthesize MotoTypeId;
@synthesize MotoTypeName;


-(void) dealloc
{
    self.MotoTypeId = nil;
    self.MotoTypeName = nil;
    
    [super dealloc];
}

@end