//
//  CourseEntity.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "CourseEntity.h"

@implementation CourseEntity
@synthesize CourseID;
@synthesize CourseName;


-(void) dealloc
{
    self.CourseID = nil;
    self.CourseName = nil;
    
    [super dealloc];
}

@end
