//
//  CommentEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "CommentEntity.h"

@implementation CommentEntity
@synthesize CommentID;
@synthesize CommentContent;
@synthesize AvgStar;
@synthesize Star1;
@synthesize Star2;
@synthesize Star3;
@synthesize Star4;
@synthesize Star5;
@synthesize ShopID;
@synthesize OrderID;
@synthesize MenuID;
@synthesize UserID;
@synthesize UserName;
@synthesize AddDate;

-(void) dealloc
{
    self.CommentID = nil;
    self.CommentContent = nil;
    self.AvgStar = nil;
    self.Star1 = nil;
    self.Star2 = nil;
    self.Star3 = nil;
    self.Star4 = nil;
    self.Star5 = nil;
    self.OrderID = nil;
    self.MenuID = nil;
    self.ShopID = nil;
    self.UserID = nil;
    self.UserName = nil;
    self.AddDate = nil;
    
    [super dealloc];
}

@end
