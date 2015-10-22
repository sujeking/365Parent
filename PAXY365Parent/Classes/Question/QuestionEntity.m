//
//  QuestionEntity.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "QuestionEntity.h"

@implementation QuestionEntity
@synthesize QuestionID;
@synthesize QuestionTitle;
@synthesize QuestionContent;
@synthesize QuestionStatus;
@synthesize QuestionType;
@synthesize UserID;
@synthesize UserAmount;
@synthesize AddDate;

-(void) dealloc
{
    self.QuestionID = nil;
    self.QuestionTitle = nil;
    self.QuestionContent = nil;
    self.QuestionType = nil;
    self.QuestionStatus = nil;
    self.UserID = nil;
    self.UserAmount = nil;
    self.AddDate = nil;
    
    [super dealloc];
}

@end
