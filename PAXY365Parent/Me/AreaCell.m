//
//  AreaCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "AreaCell.h"

#import "AreaEntity.h"
#import "Common.h"

@interface AreaCell ()

@end

@implementation AreaCell
@synthesize lblName;

-(void) layoutSubviews
{
    [super layoutSubviews];

    if ([object isKindOfClass:[AreaEntity class]])
    {
        AreaEntity *data = (AreaEntity *)object;
        lblName.text = data.AreaName;
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
