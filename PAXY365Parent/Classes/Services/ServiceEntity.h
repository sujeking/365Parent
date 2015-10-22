//
//  ServiceEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface ServiceEntity :  BaseEntity
{
    NSString *ServiceID;
    NSString *ServiceName;
    NSString *ServiceImage1;
    NSString *ServiceImage2;
    NSString *ServiceImage3;
    NSString *ServiceDesc;
    NSString *ServiceType;
    NSString *ServiceAddress;
    NSString *ServiceStatus;
    NSString *PriceNum;
    NSString *Lat;
    NSString *Lng;
    NSString *UserID;
    NSString *UserName;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *ServiceID;
@property (nonatomic,retain) NSString *ServiceName;
@property (nonatomic,retain) NSString *ServiceImage1;
@property (nonatomic,retain) NSString *ServiceImage2;
@property (nonatomic,retain) NSString *ServiceImage3;
@property (nonatomic,retain) NSString *ServiceDesc;
@property (nonatomic,retain) NSString *ServiceType;
@property (nonatomic,retain) NSString *ServiceStatus;
@property (nonatomic,retain) NSString *ServiceAddress;
@property (nonatomic,retain) NSString *PriceNum;
@property (nonatomic,retain) NSString *Lat;
@property (nonatomic,retain) NSString *Lng;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *UserName;
@property (nonatomic,retain) NSString *AddDate;

@end