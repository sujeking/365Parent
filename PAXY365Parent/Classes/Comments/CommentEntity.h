//
//  CommentEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface CommentEntity :  BaseEntity
{
    NSString *CommentID;
    NSString *CommentContent;
    NSString *AvgStar;
    NSString *Star1;
    NSString *Star2;
    NSString *Star3;
    NSString *Star4;
    NSString *Star5;
    NSString *ShopID;
    NSString *OrderID;
    NSString *MenuID;
    NSString *UserID;
    NSString *UserName;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *CommentID;
@property (nonatomic,retain) NSString *CommentContent;
@property (nonatomic,retain) NSString *AvgStar;
@property (nonatomic,retain) NSString *Star1;
@property (nonatomic,retain) NSString *Star2;
@property (nonatomic,retain) NSString *Star3;
@property (nonatomic,retain) NSString *Star4;
@property (nonatomic,retain) NSString *Star5;
@property (nonatomic,retain) NSString *ShopID;
@property (nonatomic,retain) NSString *OrderID;
@property (nonatomic,retain) NSString *MenuID;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *UserName;
@property (nonatomic,retain) NSString *AddDate;

@end