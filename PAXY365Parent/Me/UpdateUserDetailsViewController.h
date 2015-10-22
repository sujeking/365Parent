//
//  UpdateUserDetailsViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRoundView.h"
#import "MBProgressHUD.h"

@interface UpdateUserDetailsViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
     MBProgressHUD *HUD;
    
    UIScrollView *scrollView;
    
    UITextField *txtNickName;
    UITextField *txtStudentNo;
    UITextField *txtMasterName;
    UITextField *txtGradeID;
    
    UIButton *btnPost;
    UIButton *btnGenderMan;
    UIButton *btnGenderWoman;
    
    UIButton *btnSelectProvince;
    UIButton *btnSelectCity;
    UIButton *btnSelectDistrict;
    UIButton *btnSelectSchool;
    UIButton *btnSelectClass;
    
    UIImageView *userImage;

    NSString *getUserGender;
    
    //加载进度条
    GPRoundView *loadingView;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *txtNickName;
@property (nonatomic, retain) IBOutlet UITextField *txtStudentNo;
@property (nonatomic, retain) IBOutlet UITextField *txtMasterName;
@property (nonatomic, retain) IBOutlet UITextField *txtGradeID;

@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UIButton *btnGenderMan;
@property (nonatomic, retain) IBOutlet UIButton *btnGenderWoman;

@property (nonatomic, retain) IBOutlet UIButton *btnSelectProvince;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectCity;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectDistrict;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectSchool;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectClass;

@property (nonatomic, retain) IBOutlet UIImageView *userImage;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
