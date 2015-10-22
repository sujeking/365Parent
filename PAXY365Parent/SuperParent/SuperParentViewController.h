//
//  SuperParentViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee Lee on 15/6/1.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRoundView.h"

@interface SuperParentViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
    UIScrollView *scrollView;
    
    UITextView *lblContent;
    UILabel *lblInformation;
    UITextField *txtEmail;
    UILabel *lblPlaceholder;
    
    NSString *getInformation;
    
    //加载进度条
    GPRoundView *loadingView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UILabel *lblPlaceholder;
@property (nonatomic, retain) IBOutlet UITextView *lblContent;
@property (nonatomic, retain) IBOutlet UILabel *lblInformation;
@property (nonatomic, retain) IBOutlet UITextField *txtEmail;

@end
