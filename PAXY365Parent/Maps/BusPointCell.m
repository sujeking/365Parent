//
//  BusPointCell.m
//  ZNBC
//
//  Created by 杨晓龙 on 13-4-11.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import "BusPointCell.h"

@implementation BusPointCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (void)dealloc {
    [_imageView release];
    [_lblAddress release];
    [_lblDistance release];
    [_lblShopName release];
    [super dealloc];
}
@end
