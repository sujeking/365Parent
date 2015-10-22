//
//  WarningDetailsViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/17.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMapViewController.h"
#import "MBProgressHUD.h"
#import "GPRoundView.h"
#import "WarningEntity.h"

@interface WarningDetailsViewController : BaseMapViewController<MBProgressHUDDelegate>{
    
    UIScrollView *scrollView;

    WarningEntity *warningEntity;
    MBProgressHUD *HUD;
    
    UILabel *lblTitle;
    UILabel *lblDistance;
    UILabel *lblDate;
    UILabel *lblName;
    UILabel *lblClickNum;
    UITextView *lblDesc;
    UIImageView *headImage;
    UIImageView *imageView1;
    UIImageView *imageView2;
    UIImageView *imageView3;
    UIImageView *imageView4;
    UIImageView *imageView5;
    
    NSArray *arrayURL;
    
    NSString *setTitle;
    NSString *setType;

    
    //加载进度条
    GPRoundView *loadingView;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) WarningEntity *warningEntity;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblDistance;
@property (nonatomic, retain) IBOutlet UILabel *lblDate;
@property (nonatomic, retain) IBOutlet UILabel *lblName;
@property (nonatomic, retain) IBOutlet UILabel *lblClickNum;
@property (nonatomic, retain) IBOutlet UITextView *lblDesc;
@property (nonatomic, retain) IBOutlet UIImageView *headImage;
@property (nonatomic, retain) IBOutlet UIImageView *imageView1;
@property (nonatomic, retain) IBOutlet UIImageView *imageView2;
@property (nonatomic, retain) IBOutlet UIImageView *imageView3;
@property (nonatomic, retain) IBOutlet UIImageView *imageView4;
@property (nonatomic, retain) IBOutlet UIImageView *imageView5;

@property (nonatomic,retain) NSString *setTitle;
@property (nonatomic,retain) NSString *setType;


@end
