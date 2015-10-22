//
//  ContactsEntity.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface ContactsEntity : BaseEntity
{
    NSString *UserID;
    NSString *NickName;
    NSString *UserImage;
    NSString *UserPhone;
    NSString *UserGender;
    NSString *UserStatus;
    NSString *UserType;
    NSString *UserMoney;
    NSString *StudentNo;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *NickName;
@property (nonatomic,retain) NSString *UserImage;
@property (nonatomic,retain) NSString *UserPhone;
@property (nonatomic,retain) NSString *UserGender;
@property (nonatomic,retain) NSString *UserStatus;
@property (nonatomic,retain) NSString *UserType;
@property (nonatomic,retain) NSString *UserMoney;
@property (nonatomic,retain) NSString *StudentNo;
@property (nonatomic,retain) NSString *AddDate;


@end
