//
//  MessageCommentAddViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MessageCommentAddViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>{
    
    UIScrollView *scrollView;
    MBProgressHUD *HUD;
    
    UITextView *txtContent;
    UIButton *btnPost;
    UILabel *lblPlaceholder;
    UILabel *lblRemainWords;
    NSString *setMessageID;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextView *txtContent;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;
@property (nonatomic, retain) IBOutlet UILabel *lblPlaceholder;
@property (nonatomic, retain) IBOutlet UILabel *lblRemainWords;
@property (nonatomic, retain) NSString *setMessageID;


@end