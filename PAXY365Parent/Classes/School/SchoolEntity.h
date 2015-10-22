//
//  SchoolEntity.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface SchoolEntity : BaseEntity
{
    NSString *SchoolID;
    NSString *SchoolName;
}

@property (nonatomic,retain) NSString *SchoolID;
@property (nonatomic,retain) NSString *SchoolName;


@end