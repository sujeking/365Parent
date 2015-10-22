//
//  LeaveDetailsViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/21.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageEntity.h"

@interface LeaveDetailsViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    MessageEntity *messageEntity;
    
    UIImageView *headImage;
    UIImageView *imageView;
    UILabel *lblName;
    UILabel *lblDate;
    UILabel *lblDays;
    UILabel *lblStatus;
    UILabel *lblLeaveType;
    UILabel *lblLeaveTime;
    UILabel *lblReviewName;
    UITextView *lblDesc;
    
    UILabel *txtResult;
    
    UIButton *btnReviewOK;
    UIButton *btnReviewNO;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) MessageEntity *messageEntity;

@property (nonatomic, retain) IBOutlet UIImageView *headImage;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *lblName;
@property (nonatomic, retain) IBOutlet UILabel *lblDate;
@property (nonatomic, retain) IBOutlet UILabel *lblDays;
@property (nonatomic, retain) IBOutlet UILabel *lblLeaveType;
@property (nonatomic, retain) IBOutlet UILabel *lblLeaveTime;
@property (nonatomic, retain) IBOutlet UILabel *lblStatus;
@property (nonatomic, retain) IBOutlet UILabel *lblReviewName;
@property (nonatomic, retain) IBOutlet UITextView *lblDesc;

@property (nonatomic, retain) IBOutlet UILabel *txtResult;

@property (nonatomic, retain) IBOutlet UIButton *btnReviewOK;
@property (nonatomic, retain) IBOutlet UIButton *btnReviewNO;

@end
