//
//  HomeworkCell.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/17.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface HomeworkCell : BaseCustomCell
{
    UILabel *lblName;
    UILabel *lblCourse;
    UILabel *lblDesc;
    UILabel *lblDate;
    UILabel *lblStatus;
    UILabel *lblShowDate;
    UIImageView *headImage;
    UIImageView *cameraImage;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) IBOutlet UILabel *lblName;
@property (nonatomic,retain) IBOutlet UILabel *lblCourse;
@property (nonatomic,retain) IBOutlet UILabel *lblDesc;
@property (nonatomic,retain) IBOutlet UILabel *lblDate;
@property (nonatomic,retain) IBOutlet UILabel *lblStatus;
@property (nonatomic,retain) IBOutlet UILabel *lblShowDate;
@property (nonatomic,retain) IBOutlet UIImageView *headImage;
@property (nonatomic,retain) IBOutlet UIImageView *cameraImage;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end