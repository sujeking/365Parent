//
//  ChatMainViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/23.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatMainViewController : UIViewController<UISearchBarDelegate>{
    
    UILabel *lblClassName;
    
}

@property (strong, nonatomic) IBOutlet UILabel *lblClassName;

@end
