//
//  WarningEntity.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "WarningEntity.h"

@implementation WarningEntity
@synthesize SafeID;
@synthesize SafeTitle;
@synthesize SafeImage;
@synthesize ImagesList;
@synthesize UserName;
@synthesize RealName;
@synthesize SafeAddress;
@synthesize SchoolInfo;
@synthesize SafeDesc;
@synthesize SafeLat;
@synthesize SafeLng;
@synthesize UserID;
@synthesize AddDate;
@synthesize Distance;
@synthesize Unit;
@synthesize SafeStatus;
@synthesize ClickNum;
@synthesize UserImage;


-(void) dealloc
{
    self.SafeID = nil;
    self.SafeTitle = nil;
    self.SafeImage = nil;
    self.ImagesList = nil;
    self.UserName = nil;
    self.RealName = nil;
    self.SafeAddress = nil;
    self.SchoolInfo = nil;
    self.SafeDesc = nil;
    self.SafeLat = nil;
    self.SafeLng = nil;
    self.UserID = nil;
    self.AddDate = nil;
    self.Distance = nil;
    self.Unit = nil;
    self.SafeStatus = nil;
    self.UserImage= nil;
    self.ClickNum= nil;
    
    [super dealloc];
}

@end
