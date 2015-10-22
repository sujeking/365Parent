//
//  NotesViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/24.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NotesViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
    UIScrollView *scrollView;
    
    MBProgressHUD *HUD;
    

    UIButton *btnSelectType;
    UIButton *btnSelectStartTime;
    UIButton *btnSelectEndTime;
    UIButton *btnPost;
    UITextField *txtKeywords;
    
    
    UIToolbar *doneToolbar;
    UIDatePicker *startDatePicker;
    UIDatePicker *endDatePicker;

    NSString *getStartTime;
    NSString *getEndTime;
    NSString *getType;
    
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UIButton *btnSelectType;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectStartTime;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectEndTime;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UITextField *txtKeywords;

@property (nonatomic, retain) IBOutlet UIToolbar *doneToolbar;
@property (nonatomic, retain) IBOutlet UIDatePicker *startDatePicker;
@property (nonatomic, retain) IBOutlet UIDatePicker *endDatePicker;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
