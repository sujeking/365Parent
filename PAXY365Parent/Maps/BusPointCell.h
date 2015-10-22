//
//  BusPointCell.h
//  ZNBC
//
//  Created by 杨晓龙 on 13-4-11.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusPointCell : UIView

@property (retain, nonatomic) IBOutlet UILabel *lblShopName;
@property (retain, nonatomic) IBOutlet UILabel *lblDistance;
@property (retain, nonatomic) IBOutlet UILabel *lblAddress;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
