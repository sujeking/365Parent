//
//  OrderEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface OrderEntity :  BaseEntity
{
    NSString *OrderID;
    NSString *OrderMoney;
    NSString *MenusIDs;
    NSString *OrderStatus;
    NSString *StatusRemark;
    NSString *StatusID;
    NSString *OrderNum;
    NSString *Remark;
    NSString *PayStyle;
    NSString *OrderType;
    NSString *OrderAmount;
    NSString *FoodMoney;
    NSString *DeliveryMoney;
    NSString *LunchboxMoney;
    NSString *Contacts;
    NSString *InvoiceTitle;
    NSString *DeliveryTime;
    NSString *IsPay;
    NSString *ConfirmTime;
    NSString *MakeTime;
    NSString *FoodTime;
    NSString *MakeActiveTime;
    NSString *GetTime;
    NSString *FinishTime;
    NSString *ShopID;
    NSString *ShopName;
    NSString *ShopPhone;
    NSString *OfficialPhone;
    NSString *ShopImage;
    NSString *UserID;
    NSString *AddDate;

}

@property (nonatomic,retain) NSString *OrderID;
@property (nonatomic,retain) NSString *OrderMoney;
@property (nonatomic,retain) NSString *MenusIDs;
@property (nonatomic,retain) NSString *OrderStatus;
@property (nonatomic,retain) NSString *StatusRemark;
@property (nonatomic,retain) NSString *StatusID;
@property (nonatomic,retain) NSString *OrderNum;
@property (nonatomic,retain) NSString *Remark;
@property (nonatomic,retain) NSString *PayStyle;
@property (nonatomic,retain) NSString *OrderType;
@property (nonatomic,retain) NSString *OrderAmount;
@property (nonatomic,retain) NSString *FoodMoney;
@property (nonatomic,retain) NSString *DeliveryMoney;
@property (nonatomic,retain) NSString *LunchboxMoney;
@property (nonatomic,retain) NSString *Contacts;
@property (nonatomic,retain) NSString *InvoiceTitle;
@property (nonatomic,retain) NSString *DeliveryTime;
@property (nonatomic,retain) NSString *IsPay;
@property (nonatomic,retain) NSString *ConfirmTime;
@property (nonatomic,retain) NSString *MakeTime;
@property (nonatomic,retain) NSString *FoodTime;
@property (nonatomic,retain) NSString *MakeActiveTime;
@property (nonatomic,retain) NSString *GetTime;
@property (nonatomic,retain) NSString *FinishTime;
@property (nonatomic,retain) NSString *ShopID;
@property (nonatomic,retain) NSString *ShopName;
@property (nonatomic,retain) NSString *ShopPhone;
@property (nonatomic,retain) NSString *OfficialPhone;
@property (nonatomic,retain) NSString *ShopImage;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;

@end