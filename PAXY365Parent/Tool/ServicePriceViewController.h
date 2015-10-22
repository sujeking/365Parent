//
//  ServicePriceViewController.h
//  Car
//
//  Created by Cloudin's Adin on 14-8-27.
//  Copyright (c) 2014年 Shanghai Cloudin Network Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicePriceViewController : UIViewController{
    
    UIScrollView *scrollView;
    
    UITextField *txtContent;
    UIButton *btnPost;
    
    NSString *setServiceID;
}


@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *txtContent;
@property (nonatomic, retain) IBOutlet UIButton *btnPost;

@property (nonatomic, retain) NSString *setServiceID;
