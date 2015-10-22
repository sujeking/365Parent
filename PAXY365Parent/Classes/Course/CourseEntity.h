//
//  CourseEntity.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface CourseEntity : BaseEntity
{
    NSString *CourseID;
    NSString *CourseName;
}

@property (nonatomic,retain) NSString *CourseID;
@property (nonatomic,retain) NSString *CourseName;


@end