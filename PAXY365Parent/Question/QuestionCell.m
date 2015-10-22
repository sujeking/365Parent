//
//  QuestionCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "QuestionCell.h"

#import "QuestionEntity.h"
#import "Common.h"

@interface QuestionCell ()

@end

@implementation QuestionCell
@synthesize lblAddDate;
@synthesize btnStatus;
@synthesize lblTitle;

-(void) layoutSubviews
{
    [super layoutSubviews];

    
    if ([object isKindOfClass:[QuestionEntity class]])
    {
        QuestionEntity *data = (QuestionEntity *)object;
        
        lblAddDate.text =[NSString stringWithFormat:@"%@ 共%@个问题",data.AddDate,data.UserAmount];
        lblAddDate.textColor = TxtGray;
        
        
        lblTitle.text = data.QuestionTitle;
        lblTitle.textColor = TxtBlack;
        
        NSString *getStatus = data.QuestionStatus;
        if ([getStatus isEqualToString:@"1"]) {
            getStatus = @"进行中";
        }
        else{
            getStatus = @"已结束";
        }
        [btnStatus setTitle:getStatus forState:UIControlStateNormal];

        
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
