//
//  ChildViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/29.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRoundView.h"
#import "MBProgressHUD.h"

@interface ChildViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
    MBProgressHUD *HUD;
    
    UIScrollView *scrollView;
    UITextField *txtNickName;
    UIButton *btnPost;
    UIButton *btnSelectRelation;
    NSString *getRelation;
    
    //加载进度条
    GPRoundView *loadingView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *txtNickName;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UIButton *btnSelectRelation;

@end
