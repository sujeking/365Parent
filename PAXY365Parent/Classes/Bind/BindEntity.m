//
//  BindEntity.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/30.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BindEntity.h"

@implementation BindEntity
@synthesize BindID;
@synthesize ProvinceID;
@synthesize ProvinceName;
@synthesize CityID;
@synthesize CityName;
@synthesize DistrictID;
@synthesize DistrictName;
@synthesize SchoolID;
@synthesize SchoolName;
@synthesize ClassID;
@synthesize ClassName;
@synthesize GradeID;
@synthesize TeacherType;
@synthesize CourseID;
@synthesize CourseName;
@synthesize ChildRelation;
@synthesize ChildName;
@synthesize BindType;
@synthesize UserID;
@synthesize AddDate;
@synthesize BindDefault;


-(void) dealloc
{
    self.BindID = nil;
    self.ProvinceID = nil;
    self.ProvinceName = nil;
    self.CityID = nil;
    self.CityName = nil;
    self.DistrictID = nil;
    self.DistrictName = nil;
    self.SchoolID = nil;
    self.SchoolName = nil;
    self.ClassID = nil;
    self.ClassName = nil;
    self.GradeID = nil;
    self.TeacherType = nil;
    self.CourseID = nil;
    self.CourseName = nil;
    self.ChildRelation = nil;
    self.ChildName = nil;
    self.BindType = nil;
    self.BindDefault = nil;
    self.UserID = nil;
    self.AddDate = nil;
}

@end
