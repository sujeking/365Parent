//
//  InfoCell.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface InfoCell : BaseCustomCell
{
    UILabel *lblTitle;
    UILabel *lblDesc;
    UILabel *lblVisitNum;
    UILabel *lblDate;
    UIImageView *newsImage;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) IBOutlet UILabel *lblTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblDesc;
@property (nonatomic,retain) IBOutlet UILabel *lblVisitNum;
@property (nonatomic,retain) IBOutlet UILabel *lblDate;
@property (nonatomic,retain) IBOutlet UIImageView *newsImage;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end