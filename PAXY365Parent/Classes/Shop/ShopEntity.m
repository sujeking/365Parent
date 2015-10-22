//
//  ShopEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ShopEntity.h"

@interface ShopEntity ()

@end

@implementation ShopEntity
@synthesize ShopID;
@synthesize ShopName;
@synthesize ShopImage1;
@synthesize ShopImage2;
@synthesize ShopImage3;
@synthesize ShopAddress;
@synthesize ShopLicence;
@synthesize ShopDesc;
@synthesize ShopLat;
@synthesize ShopLng;
@synthesize ShopStar;
@synthesize CommentsNum;
@synthesize ShopPhone;
@synthesize UserID;
@synthesize AddDate;
@synthesize Distance;
@synthesize Unit;
@synthesize StartMoney;
@synthesize DeliveryMoney;
@synthesize LunchboxMoney;
@synthesize MakeTime;
@synthesize OpenTime;
@synthesize EndTime;
@synthesize DeliveryTime;
@synthesize BusinessStatus;
@synthesize IsBooking;
@synthesize IsOneself;
@synthesize IsTakeaway;
@synthesize SaleNum;
@synthesize ShopStatus;

-(void) dealloc
{
    self.ShopID = nil;
    self.ShopName = nil;
    self.ShopImage1 = nil;
    self.ShopImage2 = nil;
    self.ShopImage3 = nil;
    self.ShopAddress = nil;
    self.ShopLicence = nil;
    self.ShopPhone = nil;
    self.ShopDesc = nil;
    self.ShopLat = nil;
    self.ShopLng = nil;
    self.ShopStar = nil;
    self.CommentsNum = nil;
    self.UserID = nil;
    self.AddDate = nil;
    self.Distance = nil;
    self.Unit = nil;
    self.StartMoney = nil;
    self.DeliveryMoney = nil;
    self.LunchboxMoney = nil;
    self.MakeTime = nil;
    self.OpenTime = nil;
    self.EndTime = nil;
    self.DeliveryTime = nil;
    self.BusinessStatus = nil;
    self.IsOneself = nil;
    self.IsBooking = nil;
    self.IsTakeaway = nil;
    self.SaleNum = nil;
    self.ShopStatus = nil;

    
    [super dealloc];
}

@end
