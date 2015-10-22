//
//  OnlineViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee Lee on 15/6/1.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    
    UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
