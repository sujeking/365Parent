//
//  FriendsTipCell.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/23.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface FriendsTipCell : BaseCustomCell
{
    UILabel *lblName;
    UILabel *lblStatus;
    UIImageView *imageView;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) IBOutlet UILabel *lblName;
@property (nonatomic,retain) IBOutlet UILabel *lblStatus;
@property (nonatomic,retain) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end