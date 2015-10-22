//
//  ContactsEntity.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ContactsEntity.h"

@implementation ContactsEntity
@synthesize UserID;
@synthesize NickName;
@synthesize UserImage;
@synthesize UserPhone;
@synthesize UserGender;
@synthesize UserStatus;
@synthesize UserType;
@synthesize UserMoney;
@synthesize StudentNo;
@synthesize AddDate;


-(void) dealloc
{
    self.UserID = nil;
    self.NickName = nil;
    self.UserImage = nil;
    self.UserPhone = nil;
    self.UserGender = nil;
    self.UserStatus = nil;
    self.UserType = nil;
    self.UserMoney = nil;
    self.StudentNo = nil;
    self.AddDate = nil;
    

}

@end
