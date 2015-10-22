//
//  ClasssEntity.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/19.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface ClasssEntity : BaseEntity
{
    NSString *ClassID;
    NSString *ClassName;
}

@property (nonatomic,retain) NSString *ClassID;
@property (nonatomic,retain) NSString *ClassName;


@end