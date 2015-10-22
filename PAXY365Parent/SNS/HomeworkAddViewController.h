//
//  HomeworkAddViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface HomeworkAddViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
    UIScrollView *scrollView;
    
    MBProgressHUD *HUD;
    
    UITextView *txtContent;
    UIImageView *imageView7;
    UIButton *btnSelectCourse;
    UIButton *btnPost;
    UILabel *lblPlaceholder;
    
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextView *txtContent;
@property (nonatomic, retain) IBOutlet UIImageView *imageView7;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectCourse;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UILabel *lblPlaceholder;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
