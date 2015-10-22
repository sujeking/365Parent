//
//  SNSViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee Lee on 15/6/1.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXMainViewController.h"
#import "ApplyViewController.h"

@interface SNSViewController : UIViewController<UIScrollViewDelegate,IChatManagerDelegate>{
    
    UIScrollView *scrollView;
    
    UIButton *btnMessageNum1;
    UIButton *btnMessageNum2;
    UIButton *btnMessageNum3;
    UILabel *lblClassName;
    
    EMConnectionState _connectionState;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UIButton *btnMessageNum1;
@property (nonatomic, retain) IBOutlet UIButton *btnMessageNum2;
@property (nonatomic, retain) IBOutlet UIButton *btnMessageNum3;
@property (nonatomic, retain) IBOutlet UILabel *lblClassName;

@property (strong, nonatomic) HXMainViewController *hxMainController;


@end
