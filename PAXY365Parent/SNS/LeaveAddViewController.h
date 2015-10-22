//
//  LeaveAddViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LeaveAddViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UIPickerViewDelegate>{
    
    UIScrollView *scrollView;
    
    MBProgressHUD *HUD;
    
    UITextView *txtContent;
    UIImageView *imageView9;
    
    UIButton *btnSelectContacts;
    UIButton *btnSelectLeaveType;
    UIButton *btnSelectStartTime;
    UIButton *btnSelectEndTime;
    UIButton *btnPost;
    UIButton *btnClose;
    UILabel *lblPlaceholder;
    UITextField *txtDays;
    
    UIToolbar *doneToolbar;
    UIDatePicker *startDatePicker;
    UIDatePicker *endDatePicker;
    
    NSString *getContacts;
    NSString *getLeaveType;
    NSString *getStartTime;
    NSString *getEndTime;
    
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextView *txtContent;
@property (nonatomic, retain) IBOutlet UIImageView *imageView9;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectContacts;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectLeaveType;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectStartTime;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectEndTime;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;
@property (nonatomic, retain) IBOutlet UILabel *lblPlaceholder;
@property (nonatomic, retain) IBOutlet UITextField *txtDays;

@property (nonatomic, retain) IBOutlet UIToolbar *doneToolbar;
@property (nonatomic, retain) IBOutlet UIDatePicker *startDatePicker;
@property (nonatomic, retain) IBOutlet UIDatePicker *endDatePicker;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
