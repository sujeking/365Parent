//
//  MyAccountViewController.h
//  Car
//
//  Created by Cloudin's Adin on 14-8-7.
//  Copyright (c) 2014年 Shanghai Cloudin Network Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountViewController : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end
