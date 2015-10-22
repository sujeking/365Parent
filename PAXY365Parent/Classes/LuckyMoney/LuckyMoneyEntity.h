//
//  LuckyMoneyEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface LuckyMoneyEntity : BaseEntity
{
    NSString *LuckyMoneyID;
    NSString *LuckyMoneyNum;
    NSString *LuckyMoneyStatus;
    NSString *LuckyMoneyTypeID;
    NSString *LuckyMoneyName;
    NSString *ServiceTypeID;
    NSString *UserID;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *LuckyMoneyID;
@property (nonatomic,retain) NSString *LuckyMoneyNum;
@property (nonatomic,retain) NSString *LuckyMoneyStatus;
@property (nonatomic,retain) NSString *LuckyMoneyTypeID;
@property (nonatomic,retain) NSString *LuckyMoneyName;
@property (nonatomic,retain) NSString *ServiceTypeID;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;

@end