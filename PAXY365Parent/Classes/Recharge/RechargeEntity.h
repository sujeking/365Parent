//
//  RechargeEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface RechargeEntity :  BaseEntity
{
    NSString *RechargeID;
    NSString *RechargeNum;
    NSString *UserID;
    NSString *AddDate;
    
}

@property (nonatomic,retain) NSString *RechargeID;
@property (nonatomic,retain) NSString *RechargeNum;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;

@end