//
//  ProductsEntity.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ProductsEntity.h"

@implementation ProductsEntity
@synthesize ProductID;
@synthesize ProductName;
@synthesize ProductImage1;
@synthesize ProductImage2;
@synthesize ProductImage3;
@synthesize ProductType;
@synthesize ProductTypeID;
@synthesize ProductSubType;
@synthesize ProductDesc;
@synthesize ProductPrice;
@synthesize DiscountPrice;
@synthesize ProductStatus;
@synthesize ShopID;
@synthesize UserID;
@synthesize AddDate;
@synthesize ReviewContent;


-(void) dealloc
{
    self.ProductID = nil;
    self.ProductName = nil;
    self.ProductImage1 = nil;
    self.ProductImage2 = nil;
    self.ProductImage3 = nil;
    self.ProductTypeID = nil;
    self.ProductType = nil;
    self.ProductSubType = nil;
    self.ShopID = nil;
    self.ProductDesc = nil;
    self.ProductPrice = nil;
    self.DiscountPrice = nil;
    self.ProductStatus = nil;
    self.UserID = nil;
    self.AddDate = nil;
    self.ReviewContent = nil;
    
    [super dealloc];
}

@end
