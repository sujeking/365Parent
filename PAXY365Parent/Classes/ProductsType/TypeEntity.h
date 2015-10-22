//
//  TypeEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface TypeEntity : BaseEntity
{
    NSString *TypeID;
    NSString *TypeName;
    NSString *ParentID;
}

@property (nonatomic,retain) NSString *TypeID;
@property (nonatomic,retain) NSString *TypeName;
@property (nonatomic,retain) NSString *ParentID;

@end