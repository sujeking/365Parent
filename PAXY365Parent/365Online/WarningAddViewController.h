//
//  WarningAddViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "GPRoundView.h"

@interface WarningAddViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
    UIScrollView *scrollView;
    
    MBProgressHUD *HUD;
    
    UITextField *txtTitle;
    UITextView *txtContent;
    
    //加载进度条
    GPRoundView *loadingView;
    
    UIImageView *imageView1;
    UIImageView *imageView2;
    UIImageView *imageView3;
    UIImageView *imageView4;
    UIImageView *imageView5;
    
    UIButton *imageUpload1;
    UIButton *imageUpload2;
    UIButton *imageUpload3;
    UIButton *imageUpload4;
    UIButton *imageUpload5;
    
    UIButton *btnPost;
    UILabel *lblPlaceholder;
    UILabel *lblLimitWords;
    

    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *txtTitle;
@property (nonatomic, retain) IBOutlet UITextView *txtContent;

@property (nonatomic, retain) IBOutlet UIImageView *imageView1;
@property (nonatomic, retain) IBOutlet UIImageView *imageView2;
@property (nonatomic, retain) IBOutlet UIImageView *imageView3;
@property (nonatomic, retain) IBOutlet UIImageView *imageView4;
@property (nonatomic, retain) IBOutlet UIImageView *imageView5;

@property (nonatomic, retain) IBOutlet UIButton *imageUpload1;
@property (nonatomic, retain) IBOutlet UIButton *imageUpload2;
@property (nonatomic, retain) IBOutlet UIButton *imageUpload3;
@property (nonatomic, retain) IBOutlet UIButton *imageUpload4;
@property (nonatomic, retain) IBOutlet UIButton *imageUpload5;

@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UILabel *lblPlaceholder;
@property (nonatomic, retain) IBOutlet UILabel *lblLimitWords;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
