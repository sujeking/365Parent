//
//  SchoolCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "SchoolCell.h"

#import "SchoolEntity.h"
#import "Common.h"

@interface SchoolCell ()

@end

@implementation SchoolCell
@synthesize lblName;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    if ([object isKindOfClass:[SchoolEntity class]])
    {
        SchoolEntity *data = (SchoolEntity *)object;
        lblName.text = data.SchoolName;
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
