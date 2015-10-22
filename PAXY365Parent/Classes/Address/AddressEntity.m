//
//  AddressEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "AddressEntity.h"

@implementation AddressEntity
@synthesize AddressID;
@synthesize AddressName;
@synthesize AddressIntro;
@synthesize AddressPhone;
@synthesize UserID;
@synthesize AddDate;
@synthesize AreaID;
@synthesize AreaName;
@synthesize DistrictID;
@synthesize DistrictName;

-(void) dealloc
{
    self.AddressID = nil;
    self.AddressName = nil;
    self.AddressIntro = nil;
    self.AddressPhone = nil;
    self.UserID = nil;
    self.AddDate = nil;
    self.AreaID = nil;
    self.AreaName = nil;
    self.DistrictID = nil;
    self.DistrictName = nil;
    
    [super dealloc];
}

@end


