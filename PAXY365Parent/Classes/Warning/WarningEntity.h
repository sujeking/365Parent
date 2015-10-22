//
//  WarningEntity.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface WarningEntity : BaseEntity
{
    NSString *SafeID;
    NSString *SafeTitle;
    NSString *SafeImage;
    NSString *ImagesList;
    NSString *UserName;
    NSString *RealName;
    NSString *SafeAddress;
    NSString *SchoolInfo;
    NSString *SafeDesc;
    NSString *SafeLat;
    NSString *SafeLng;
    NSString *UserID;
    NSString *AddDate;
    NSString *Distance;
    NSString *Unit;
    NSString *SafeStatus;
    NSString *UserImage;
    NSString *ClickNum;
}

@property (nonatomic,retain) NSString *SafeID;
@property (nonatomic,retain) NSString *SafeTitle;
@property (nonatomic,retain) NSString *SafeImage;
@property (nonatomic,retain) NSString *ImagesList;
@property (nonatomic,retain) NSString *UserName;
@property (nonatomic,retain) NSString *RealName;
@property (nonatomic,retain) NSString *SafeAddress;
@property (nonatomic,retain) NSString *SchoolInfo;
@property (nonatomic,retain) NSString *SafeDesc;
@property (nonatomic,retain) NSString *SafeLat;
@property (nonatomic,retain) NSString *SafeLng;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;
@property (nonatomic,retain) NSString *Distance;
@property (nonatomic,retain) NSString *Unit;
@property (nonatomic,retain) NSString *SafeStatus;
@property (nonatomic,retain) NSString *UserImage;
@property (nonatomic,retain) NSString *ClickNum;

@end
