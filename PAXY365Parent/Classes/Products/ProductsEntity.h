//
//  ProductsEntity.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "BaseEntity.h"

@interface ProductsEntity :  BaseEntity
{
    NSString *ProductID;
    NSString *ProductName;
    NSString *ProductImage1;
    NSString *ProductImage2;
    NSString *ProductImage3;
    NSString *ProductTypeID;
    NSString *ProductType;
    NSString *ProductSubType;
    NSString *ProductDesc;
    NSString *ProductStatus;
    NSString *ProductPrice;
    NSString *DiscountPrice;
    NSString *ReviewContent;
    NSString *ShopID;
    NSString *UserID;
    NSString *AddDate;
}

@property (nonatomic,retain) NSString *ProductID;
@property (nonatomic,retain) NSString *ProductName;
@property (nonatomic,retain) NSString *ProductImage1;
@property (nonatomic,retain) NSString *ProductImage2;
@property (nonatomic,retain) NSString *ProductImage3;
@property (nonatomic,retain) NSString *ProductTypeID;
@property (nonatomic,retain) NSString *ProductType;
@property (nonatomic,retain) NSString *ProductSubType;
@property (nonatomic,retain) NSString *ProductDesc;
@property (nonatomic,retain) NSString *ProductStatus;
@property (nonatomic,retain) NSString *ProductPrice;
@property (nonatomic,retain) NSString *DiscountPrice;
@property (nonatomic,retain) NSString *ReviewContent;
@property (nonatomic,retain) NSString *ShopID;
@property (nonatomic,retain) NSString *UserID;
@property (nonatomic,retain) NSString *AddDate;

@end