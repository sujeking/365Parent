//
//  QuestionEntity.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface QuestionEntity :  BaseEntity
{
    NSString *QuestionID;
    NSString *QuestionTitle;
    NSString *QuestionContent;
    NSString *QuestionType;
    NSString *QuestionStatus;
    NSString *UserID;
    NSString *UserAmount;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *QuestionID;
@property (nonatomic,retain) NSString *QuestionTitle;
@property (nonatomic,retain) NSString *QuestionContent;
@property (nonatomic,retain) NSString *QuestionType;
@property (nonatomic,retain) NSString *QuestionStatus;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *UserAmount;
@property (nonatomic,retain) NSString *AddDate;

@end