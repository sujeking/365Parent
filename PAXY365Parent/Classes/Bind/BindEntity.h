//
//  BindEntity.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/30.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface BindEntity : BaseEntity
{
    NSString *BindID;
    NSString *ProvinceID;
    NSString *ProvinceName;
    NSString *CityID;
    NSString *CityName;
    NSString *DistrictID;
    NSString *DistrictName;
    NSString *SchoolID;
    NSString *SchoolName;
    NSString *ClassID;
    NSString *ClassName;
    NSString *GradeID;
    NSString *TeacherType;
    NSString *CourseID;
    NSString *CourseName;
    NSString *ChildRelation;
    NSString *ChildName;
    NSString *BindType;
    NSString *BindDefault;
    NSString *UserID;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *BindID;
@property (nonatomic,retain) NSString *ProvinceID;
@property (nonatomic,retain) NSString *ProvinceName;
@property (nonatomic,retain) NSString *CityID;
@property (nonatomic,retain) NSString *CityName;
@property (nonatomic,retain) NSString *DistrictID;
@property (nonatomic,retain) NSString *DistrictName;
@property (nonatomic,retain) NSString *SchoolID;
@property (nonatomic,retain) NSString *SchoolName;
@property (nonatomic,retain) NSString *ClassID;
@property (nonatomic,retain) NSString *ClassName;
@property (nonatomic,retain) NSString *GradeID;
@property (nonatomic,retain) NSString *TeacherType;
@property (nonatomic,retain) NSString *CourseID;
@property (nonatomic,retain) NSString *CourseName;
@property (nonatomic,retain) NSString *ChildRelation;
@property (nonatomic,retain) NSString *ChildName;
@property (nonatomic,retain) NSString *BindType;
@property (nonatomic,retain) NSString *BindDefault;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;


@end
