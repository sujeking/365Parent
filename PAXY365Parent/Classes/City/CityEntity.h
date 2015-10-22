//
//  CityEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface CityEntity : BaseEntity
{
    NSString *cityId;
    NSString *cityName;
}

@property (nonatomic,retain) NSString *cityId;
@property (nonatomic,retain) NSString *cityName;


@end
