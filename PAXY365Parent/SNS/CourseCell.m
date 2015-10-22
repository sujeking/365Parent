//
//  CourseCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "CourseCell.h"

#import "CourseEntity.h"
#import "Common.h"

@interface CourseCell ()

@end

@implementation CourseCell
@synthesize lblName;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    if ([object isKindOfClass:[CourseEntity class]])
    {
        CourseEntity *data = (CourseEntity *)object;
        lblName.text = data.CourseName;
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
