//
//  MotoTypeEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface MotoTypeEntity : BaseEntity
{
    NSString *MotoTypeId;
    NSString *MotoTypeName;
}

@property (nonatomic,retain) NSString *MotoTypeId;
@property (nonatomic,retain) NSString *MotoTypeName;


@end
