//
//  UpdateUserPasswordViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRoundView.h"
#import "MBProgressHUD.h"

@interface UpdateUserPasswordViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate>{
    
    UIScrollView *scrollView;
    MBProgressHUD *HUD;
    
    UITextField *txtPassword;
    UITextField *txtRePassword;
    
    UIButton *btnPost;
    
    //加载进度条
    GPRoundView *loadingView;
    
    //多语言定义显示
    UILabel *langLblNewPassword;
    UILabel *langLblRePassword;
    
    NSString *langTxtPasswordTip;
    NSString *langTxtPasswordCheck;
    NSString *langTxtRePasswordTip;
    NSString *langTxtCheckTwicePassword;

}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITextField *txtRePassword;
@property (nonatomic, retain) IBOutlet UILabel *langLblNewPassword;
@property (nonatomic, retain) IBOutlet UILabel *langLblRePassword;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;

@end
