//
//  UserCheckMobileViewController.h
//  WeCicerone
//
//  Created by Cloudin's Adin on 14-9-15.
//  Copyright (c) 2014年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCheckMobileViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    
    UITextField *txtSMSCode;
    UITextField *txtPassword;
    UITextField *txtRePassword;
    UITextField *txtNiceName;
    UIButton *btnPost;
    
    UILabel *lblShowMessage;
    
    UIButton *btnCheck;
    UIButton *btnPrivacy;
    
    NSInteger num;
    NSInteger ok;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *txtSMSCode;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITextField *txtRePassword;
@property (nonatomic, retain) IBOutlet UILabel *lblShowMessage;
@property (nonatomic, retain) IBOutlet UITextField *txtNiceName;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UIButton *btnCheck;
@property (nonatomic, retain) IBOutlet UIButton *btnPrivacy;

@end
