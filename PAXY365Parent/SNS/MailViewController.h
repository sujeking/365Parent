//
//  MailViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/17.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    
    UIButton *btnMessageNum1;
    UIButton *btnMessageNum2;
    UIButton *btnMessageNum3;
    UIButton *btnMessageNum4;
    UIButton *btnMessageNum5;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIButton *btnMessageNum1;
@property (nonatomic, retain) IBOutlet UIButton *btnMessageNum2;
@property (nonatomic, retain) IBOutlet UIButton *btnMessageNum3;
@property (nonatomic, retain) IBOutlet UIButton *btnMessageNum4;
@property (nonatomic, retain) IBOutlet UIButton *btnMessageNum5;

@end
