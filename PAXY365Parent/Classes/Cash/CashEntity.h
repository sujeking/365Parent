//
//  CashEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface CashEntity :  BaseEntity
{
    NSString *CashID;
    NSString *CashNum;
    NSString *CashStatus;
    NSString *ShopID;
    NSString *AddDate;
    
}

@property (nonatomic,retain) NSString *CashID;
@property (nonatomic,retain) NSString *CashNum;
@property (nonatomic,retain) NSString *CashStatus;
@property (nonatomic,retain) NSString *ShopID;
@property (nonatomic,retain) NSString *AddDate;

@end