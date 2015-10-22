//
//  CustomOrderEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//
#import "CustomOrderEntity.h"

@implementation CustomOrderEntity
@synthesize CustomID;
@synthesize CustomName;
@synthesize CustomContent;
@synthesize CustomPrice;
@synthesize CustomStatus;
@synthesize ShopID;
@synthesize UserID;
@synthesize AddDate;
@synthesize UserPhone;

-(void) dealloc
{
    self.CustomID = nil;
    self.CustomName = nil;
    self.CustomContent = nil;
    self.CustomPrice = nil;
    self.CustomStatus = nil;
    self.ShopID = nil;
    self.UserID = nil;
    self.UserPhone = nil;
    self.AddDate = nil;
    
    [super dealloc];
}

@end
