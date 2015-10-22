//
//  ServiceEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ServiceEntity.h"

@implementation ServiceEntity
@synthesize ServiceID;
@synthesize ServiceName;
@synthesize ServiceImage1;
@synthesize ServiceImage2;
@synthesize ServiceImage3;
@synthesize ServiceDesc;
@synthesize ServiceType;
@synthesize ServiceAddress;
@synthesize ServiceStatus;
@synthesize PriceNum;
@synthesize Lat;
@synthesize Lng;
@synthesize UserID;
@synthesize UserName;
@synthesize AddDate;

-(void) dealloc
{
    self.ServiceID = nil;
    self.ServiceName = nil;
    self.ServiceImage1 = nil;
    self.ServiceImage2 = nil;
    self.ServiceImage3 = nil;
    self.ServiceDesc = nil;
    self.ServiceType = nil;
    self.ServiceAddress = nil;
    self.ServiceStatus = nil;
    self.PriceNum = nil;
    self.UserID = nil;
    self.Lat = nil;
    self.Lng = nil;
    self.UserName = nil;
    self.AddDate = nil;
    
    [super dealloc];
}

@end
