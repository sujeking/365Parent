//
//  SettingViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    
    UILabel *lblCache;
    UISwitch *switchMessage;
    UILabel *lblVersion;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *lblCache;
@property (nonatomic, retain) IBOutlet UISwitch *switchMessage;
@property (nonatomic, retain) IBOutlet UILabel *lblVersion;



@end