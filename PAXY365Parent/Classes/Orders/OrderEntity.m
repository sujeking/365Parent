//
//  OrderEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "OrderEntity.h"

@implementation OrderEntity
@synthesize OrderID;
@synthesize OrderMoney;
@synthesize MenusIDs;
@synthesize OrderStatus;
@synthesize StatusRemark;
@synthesize OrderNum;
@synthesize ShopID;
@synthesize ShopImage;
@synthesize UserID;
@synthesize AddDate;
@synthesize Remark;
@synthesize PayStyle;
@synthesize OrderType;
@synthesize OrderAmount;
@synthesize FoodMoney;
@synthesize DeliveryMoney;
@synthesize LunchboxMoney;
@synthesize Contacts;
@synthesize InvoiceTitle;
@synthesize DeliveryTime;
@synthesize IsPay;
@synthesize ConfirmTime;
@synthesize MakeTime;
@synthesize FoodTime;
@synthesize StatusID;
@synthesize MakeActiveTime;
@synthesize GetTime;
@synthesize FinishTime;
@synthesize ShopPhone;
@synthesize OfficialPhone;
@synthesize ShopName;

-(void) dealloc
{
    self.OrderID = nil;
    self.OrderMoney = nil;
    self.MenusIDs = nil;
    self.OrderStatus = nil;
    self.OrderNum = nil;
    self.UserID = nil;
    self.ShopID = nil;
    self.ShopImage = nil;
    self.AddDate = nil;
    self.Remark = nil;
    self.PayStyle = nil;
    self.OrderType = nil;
    self.OrderAmount = nil;
    self.FoodMoney = nil;
    self.DeliveryMoney = nil;
    self.LunchboxMoney = nil;
    self.Contacts = nil;
    self.InvoiceTitle = nil;
    self.DeliveryTime = nil;
    self.IsPay = nil;
    self.ConfirmTime = nil;
    self.MakeTime = nil;
    self.FoodTime = nil;
    self.StatusRemark = nil;
    self.StatusID = nil;
    self.MakeActiveTime = nil;
    self.FinishTime = nil;
    self.GetTime = nil;
    self.ShopPhone = nil;
    self.OfficialPhone = nil;
    self.ShopName = nil;
    
    [super dealloc];
}

@end
