//
//  GuideViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GuideViewController : BaseViewController<UIScrollViewDelegate>
{
    UIScrollView *bigScrollView;
    UIButton *btnEnter;
    UIPageControl *pageControl;
    
    int pageNum;

    //UIImageView *guideImage;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) IBOutlet UIButton *btnEnter;
@property (nonatomic,retain) IBOutlet UIPageControl *pageControl;
//@property (nonatomic,retain) IBOutlet UIImageView *guideImage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
