//
//  CustomOrderEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface CustomOrderEntity : BaseEntity
{
    NSString *CustomID;
    NSString *CustomName;
    NSString *CustomStatus;
    NSString *CustomContent;
    NSString *CustomPrice;
    NSString *ShopID;
    NSString *UserID;
    NSString *UserPhone;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *CustomID;
@property (nonatomic,retain) NSString *CustomName;
@property (nonatomic,retain) NSString *CustomStatus;
@property (nonatomic,retain) NSString *CustomContent;
@property (nonatomic,retain) NSString *CustomPrice;
@property (nonatomic,retain) NSString *ShopID;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *UserPhone;
@property (nonatomic,retain) NSString *AddDate;

@end