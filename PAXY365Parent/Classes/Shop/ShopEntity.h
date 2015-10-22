//
//  ShopEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface ShopEntity :  BaseEntity
{
    NSString *ShopID;
    NSString *ShopName;
    NSString *ShopImage1;
    NSString *ShopImage2;
    NSString *ShopImage3;
    NSString *ShopAddress;
    NSString *ShopLicence;
    NSString *ShopDesc;
    NSString *ShopPhone;
    NSString *ShopLat;
    NSString *ShopLng;
    NSString *ShopStar;
    NSString *CommentsNum;
    NSString *UserID;
    NSString *AddDate;
    NSString *Distance;
    NSString *Unit;
    NSString *StartMoney;
    NSString *DeliveryMoney;
    NSString *LunchboxMoney;
    NSString *MakeTime;
    NSString *OpenTime;
    NSString *EndTime;
    NSString *DeliveryTime;
    NSString *BusinessStatus;
    NSString *ShopStatus;
    NSString *IsOneself;
    NSString *IsBooking;
    NSString *IsTakeaway;
    NSString *SaleNum;
}

@property (nonatomic,retain) NSString *ShopID;
@property (nonatomic,retain) NSString *ShopName;
@property (nonatomic,retain) NSString *ShopImage1;
@property (nonatomic,retain) NSString *ShopImage2;
@property (nonatomic,retain) NSString *ShopImage3;
@property (nonatomic,retain) NSString *ShopAddress;
@property (nonatomic,retain) NSString *ShopLicence;
@property (nonatomic,retain) NSString *ShopDesc;
@property (nonatomic,retain) NSString *ShopPhone;
@property (nonatomic,retain) NSString *ShopLat;
@property (nonatomic,retain) NSString *ShopLng;
@property (nonatomic,retain) NSString *ShopStar;
@property (nonatomic,retain) NSString *CommentsNum;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;
@property (nonatomic,retain) NSString *Distance;
@property (nonatomic,retain) NSString *Unit;
@property (nonatomic,retain) NSString *StartMoney;
@property (nonatomic,retain) NSString *DeliveryMoney;
@property (nonatomic,retain) NSString *LunchboxMoney;
@property (nonatomic,retain) NSString *MakeTime;
@property (nonatomic,retain) NSString *OpenTime;
@property (nonatomic,retain) NSString *EndTime;
@property (nonatomic,retain) NSString *DeliveryTime;
@property (nonatomic,retain) NSString *BusinessStatus;
@property (nonatomic,retain) NSString *ShopStatus;
@property (nonatomic,retain) NSString *IsOneself;
@property (nonatomic,retain) NSString *IsBooking;
@property (nonatomic,retain) NSString *IsTakeaway;
@property (nonatomic,retain) NSString *SaleNum;

@end