//
//  ForgetPasswordViewController.h
//  JiaQiQu
//
//  Created by Cloudin's Adin on 14-2-14.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRoundView.h"

@interface ForgetPasswordViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    
    UITextField *txtMobilePhone;
    UITextField *txtCode;
    UITextField *txtPassword;
    UITextField *txtRePassword;
    
    UIButton *btnPost;
    UIButton *btnMobileCode;
    
    NSString *getValidateCode;
    int flagMobile;
    
    //加载进度条
    GPRoundView *loadingView;
    
    int secondsNum;
    NSTimer *timerSeconds;
    
    //多语言定义显示
    UILabel *langLblTips;
    UILabel *langLblMoiblePhone;
    UILabel *langLblCode;
    
    NSString *langTxtMoblePhoneTip;
    NSString *langTxtCheckMobileCorrect;
    NSString *langTxtCheckMobileIsNotExist;
    NSString *langTxtCodeTip;
    NSString *langTxtCheckCodeCorrect;
    NSString *langTxtCheckCodeSend;

    NSString *langTxtAlertWarning;
    NSString *langTxtAlertOK;
    NSString *langTxtAlertFail;
    NSString *langTxtNetwork;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *txtMobilePhone;
@property (nonatomic, retain) IBOutlet UITextField *txtCode;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITextField *txtRePassword;

@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UIButton *btnMobileCode;

@property (nonatomic, retain) IBOutlet UILabel *langLblMoiblePhone;
@property (nonatomic, retain) IBOutlet UILabel *langLblCode;
@property (nonatomic, retain) IBOutlet UILabel *langLblTips;

@end
