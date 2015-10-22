//
//  ClassCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ClassCell.h"

#import "ClasssEntity.h"
#import "Common.h"

@interface ClassCell ()

@end

@implementation ClassCell
@synthesize lblName;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    if ([object isKindOfClass:[ClasssEntity class]])
    {
        ClasssEntity *data = (ClasssEntity *)object;
        lblName.text = data.ClassName;
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
