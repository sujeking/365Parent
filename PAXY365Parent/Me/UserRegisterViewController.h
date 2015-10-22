//
//  UserRegisterViewController.h
//  WeCicerone
//
//  Created by Cloudin's Adin on 14-9-15.
//  Copyright (c) 2014年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserRegisterViewController : UIViewController<UIScrollViewDelegate>{
    UIScrollView *scrollView;
    UITextField *txtMobile;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *txtMobile;

@end
