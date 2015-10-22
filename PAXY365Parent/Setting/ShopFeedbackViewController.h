//
//  ShopFeedbackViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPRoundView.h"

@interface ShopFeedbackViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
    UIScrollView *scrollView;
    
    UITextView *lblContent;
    UIButton *btnPost;
    UILabel *lblPlaceholder;
    
    NSString *setShopID;
    NSString *setShopName;
    
    //加载进度条
    GPRoundView *loadingView;
    
    //多语言定义显示
    NSString *langTxtYourSuggestion;
    NSString *langTxtSuccess;
    NSString *langTxtAlertWarning;
    NSString *langTxtAlertOK;
    NSString *langTxtAlertFail;
    NSString *langTxtNetwork;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) NSString *setShopID;
@property (nonatomic, retain) NSString *setShopName;

@property (nonatomic, retain) IBOutlet UITextView *lblContent;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UILabel *lblPlaceholder;

@end
