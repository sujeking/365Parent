//
//  BindCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/30.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BindCell.h"

#import "BindEntity.h"
#import "Common.h"

@interface BindCell ()

@end

@implementation BindCell
@synthesize lblCourseName;
@synthesize lblTeacherType;
@synthesize lblIsDefault;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    if ([object isKindOfClass:[BindEntity class]])
    {
        BindEntity *data = (BindEntity *)object;
        
        NSString *getTeacherType = data.TeacherType;
        if ([getTeacherType isEqualToString:@"1"]) {
            getTeacherType = @"任课教师";
        }
        else{
            getTeacherType = @"班主任";
        }
        
        lblTeacherType.text = data.SchoolName;
        lblCourseName.text = [NSString stringWithFormat:@"%@(%@)班",data.ClassName,data.GradeID];
        lblCourseName.textColor = TxtGray;
        
        //默认
        NSString *getDefault = data.BindDefault;
        if ([getDefault isEqualToString:@"1"]) {
            getDefault = @"默认";
        }
        else{
            getDefault = @"";
        }
        lblIsDefault.text = getDefault;
        lblIsDefault.textColor = TxtBlue;
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
