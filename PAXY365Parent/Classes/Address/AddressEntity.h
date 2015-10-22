//
//  AddressEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface AddressEntity : BaseEntity
{
    NSString *AddressID;
    NSString *AddressName;
    NSString *AddressIntro;
    NSString *AddressPhone;
    NSString *UserID;
    NSString *AddDate;
    NSString *AreaID;
    NSString *AreaName;
    NSString *DistrictID;
    NSString *DistrictName;
}

@property (nonatomic,retain) NSString *AddressID;
@property (nonatomic,retain) NSString *AddressName;
@property (nonatomic,retain) NSString *AddressIntro;
@property (nonatomic,retain) NSString *AddressPhone;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;
@property (nonatomic,retain) NSString *AreaID;
@property (nonatomic,retain) NSString *AreaName;
@property (nonatomic,retain) NSString *DistrictID;
@property (nonatomic,retain) NSString *DistrictName;

@end