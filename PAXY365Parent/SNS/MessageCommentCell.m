//
//  MessageCommentCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MessageCommentCell.h"

#import "CommentEntity.h"
#import "Common.h"

@interface MessageCommentCell ()

@end

@implementation MessageCommentCell
@synthesize lblAuthor;
@synthesize lblContent;
@synthesize lblDate;

-(void) layoutSubviews
{
    [super layoutSubviews];

    if ([object isKindOfClass:[CommentEntity class]])
    {
        CommentEntity *data = (CommentEntity *)object;
        
        lblContent.text = data.CommentContent;
        lblContent.textColor = TxtGray;
        
        lblAuthor.text = data.UserName;
        lblAuthor.textColor = TxtBlue;
        
        lblDate.text = data.AddDate;
        lblDate.textColor = TxtLightGray;
        
        
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
