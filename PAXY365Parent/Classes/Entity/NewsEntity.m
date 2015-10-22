//
//  NewsEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "NewsEntity.h"

@implementation NewsEntity
@synthesize newsId;
@synthesize newsTitle;
@synthesize newsContent;
@synthesize newsType;
@synthesize newsStatus;
@synthesize visitNum;
@synthesize addDate;
@synthesize newsAuthor;
@synthesize newsDesc;
@synthesize newsImage;
@synthesize userId;
@synthesize titleB;
@synthesize titleColor;
@synthesize showDate;
@synthesize showImg;
@synthesize userImage;
@synthesize nickName;


-(void) dealloc
{
    self.newsId = nil;
    self.newsTitle = nil;
    self.newsContent = nil;
    self.newsType = nil;
    self.newsStatus = nil;
    self.visitNum = nil;
    self.newsImage = nil;
    self.newsAuthor = nil;
    self.newsDesc = nil;
    self.newsImage = nil;
    self.userId = nil;
    self.showImg = nil;
    self.showDate = nil;
    self.titleColor = nil;
    self.titleB = nil;
    self.addDate = nil;
    self.nickName = nil;
    self.userImage = nil;

    [super dealloc];
}

@end
