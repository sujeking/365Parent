//
//  CashEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "CashEntity.h"

@implementation CashEntity
@synthesize CashID;
@synthesize CashNum;
@synthesize CashStatus;
@synthesize ShopID;
@synthesize AddDate;

-(void) dealloc
{
    self.CashID = nil;
    self.CashNum = nil;
    self.CashStatus = nil;
    self.ShopID = nil;
    self.AddDate = nil;
    
    [super dealloc];
}

@end
