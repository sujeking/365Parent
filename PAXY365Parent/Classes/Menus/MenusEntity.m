//
//  MenusEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MenusEntity.h"

@implementation MenusEntity
@synthesize MenuID;
@synthesize MenuName;
@synthesize ShopID;
@synthesize CategoryID;
@synthesize MenuImage;
@synthesize MenuPrice;
@synthesize AddDate;
@synthesize MakeTime;
@synthesize SaleNum;
@synthesize MenuStatus;
@synthesize ShowMonth;
@synthesize ShowWeek;
@synthesize ShowTime;
@synthesize MenuType;
@synthesize MainDishTaste;
@synthesize DishSub;
@synthesize DishFree;
@synthesize FollowDrink;
@synthesize TastePreference;
@synthesize MainTransfer;
@synthesize SubTransfer;
@synthesize JoinNum;
@synthesize TransferPrice;

-(void) dealloc
{
    self.MenuID = nil;
    self.MenuName = nil;
    self.ShopID = nil;
    self.CategoryID = nil;
    self.MenuImage = nil;
    self.MenuPrice = nil;
    self.AddDate = nil;
    self.MakeTime = nil;
    self.SaleNum = nil;
    self.MenuStatus = nil;
    self.ShowMonth = nil;
    self.ShowWeek = nil;
    self.ShowTime = nil;
    self.MenuType = nil;
    self.MainDishTaste = nil;
    self.DishSub = nil;
    self.DishFree = nil;
    self.FollowDrink = nil;
    self.TastePreference = nil;
    self.MainTransfer = nil;
    self.SubTransfer = nil;
    self.JoinNum = nil;
    self.TransferPrice = nil;
    
    [super dealloc];
}

@end


