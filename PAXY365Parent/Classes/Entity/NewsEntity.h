//
//  NewsEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface NewsEntity : BaseEntity
{
    NSString *newsId;
    NSString *newsTitle;
    NSString *newsContent;
    NSString *newsType;
    NSString *newsStatus;
    NSString *visitNum;
    NSString *newsAuthor;
    NSString *newsDesc;
    NSString *newsImage;
    NSString *userId;
    NSString *titleB;
    NSString *titleColor;
    NSString *showImg;
    NSString *showDate;
    NSString *addDate;
    NSString *nickName;
    NSString *userImage;
}

@property (nonatomic,retain) NSString *newsId;
@property (nonatomic,retain) NSString *newsTitle;
@property (nonatomic,retain) NSString *newsContent;
@property (nonatomic,retain) NSString *newsType;
@property (nonatomic,retain) NSString *newsStatus;
@property (nonatomic,retain) NSString *visitNum;
@property (nonatomic,retain) NSString *newsAuthor;
@property (nonatomic,retain) NSString *newsDesc;
@property (nonatomic,retain) NSString *newsImage;
@property (nonatomic,retain) NSString *userId;
@property (nonatomic,retain) NSString *titleB;
@property (nonatomic,retain) NSString *titleColor;
@property (nonatomic,retain) NSString *showImg;
@property (nonatomic,retain) NSString *showDate;
@property (nonatomic,retain) NSString *addDate;
@property (nonatomic,retain) NSString *nickName;
@property (nonatomic,retain) NSString *userImage;

@end
