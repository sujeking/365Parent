//
//  LuckyMoneyEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "LuckyMoneyEntity.h"

@implementation LuckyMoneyEntity
@synthesize LuckyMoneyID;
@synthesize LuckyMoneyNum;
@synthesize LuckyMoneyStatus;
@synthesize LuckyMoneyTypeID;
@synthesize LuckyMoneyName;
@synthesize ServiceTypeID;
@synthesize UserID;
@synthesize AddDate;

-(void) dealloc
{
    self.LuckyMoneyID = nil;
    self.LuckyMoneyNum = nil;
    self.LuckyMoneyStatus = nil;
    self.LuckyMoneyTypeID = nil;
    self.LuckyMoneyName = nil;
    self.ServiceTypeID = nil;
    self.UserID = nil;
    self.AddDate = nil;
    
    [super dealloc];
}

@end
