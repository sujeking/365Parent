//
//  TasteEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface TasteEntity : BaseEntity
{
    NSString *TasteID;
    NSString *TasteName;
    NSString *UserID;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *TasteID;
@property (nonatomic,retain) NSString *TasteName;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;
@end