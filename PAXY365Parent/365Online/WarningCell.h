//
//  WarningCell.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/17.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface WarningCell : BaseCustomCell
{
    UILabel *lblTitle;
    UILabel *lblDistance;
    UILabel *lblName;
    UILabel *lblStatus;
    UIImageView *newsImage;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) IBOutlet UILabel *lblTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblDistance;
@property (nonatomic,retain) IBOutlet UILabel *lblName;
@property (nonatomic,retain) IBOutlet UILabel *lblStatus;
@property (nonatomic,retain) IBOutlet UIImageView *newsImage;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end