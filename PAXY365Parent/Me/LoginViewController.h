//
//  LoginViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "GPRoundView.h"

@interface LoginViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate,UITextFieldDelegate>{
    
    MBProgressHUD *HUD;
    UIScrollView *scrollView;
    
    UITextField *txtUserName;
    UITextField *txtPassword;
    
    UIButton *btnLogin;
    UIButton *btnForgetPassword;
    
    int flagSavePassword;
    int flagAutoLogin;
    
    //加载进度条
    GPRoundView *loadingView;

    UILabel *langLblMoiblePhone;
    UILabel *langLblPassword;
    UIButton *langBtnRegister;
    NSString *langTxtMoblePhoneTip;
    NSString *langTxtPasswordTip;
    
    NSString *langTxtCheckMobileNULL;
    NSString *langTxtCheckMobile;
    NSString *langTxtCheckMobileCorrect;
    NSString *langTxtCheckPasswordNULL;
    NSString *langTxtCheckTooShort;
    NSString *langTxtCheckTooLong;
    NSString *langTxtPasswordCheck;
    
    NSString *langTxtMessagePassword;
    NSString *langTxtMessageMobile;
    NSString *langTxtMessageException;
    NSString *langTxtAlertWarning;
    NSString *langTxtAlertOK;
    NSString *langTxtNetwork;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *txtUserName;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UIButton *btnLogin;
@property (nonatomic, retain) IBOutlet UIButton *btnForgetPassword;

@property (nonatomic, retain) IBOutlet UILabel *langLblMoiblePhone;
@property (nonatomic, retain) IBOutlet UILabel *langLblPassword;
@property (nonatomic, retain) IBOutlet UIButton *langBtnRegister;


@end
