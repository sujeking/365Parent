//
//  MeViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-01-03
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MeViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate,UIGestureRecognizerDelegate>{
    
    MBProgressHUD *HUD;
    UIScrollView *scrollView;
    
    UIImageView *userImage;
    
    UILabel *lblCity;
    UIButton *btnShowMessageCount;
    UIButton *btnExist;
    UILabel *lblChild;
    
    UIActivityIndicatorView *headActivityIndicator;
    
    UILabel *langTxtMyInfo;
    UILabel *langTxtPassword;
    UILabel *langTxtMyFavorite;
    UILabel *langTxtMyComment;
    UILabel *langTxtMyAddress;
    UILabel *langTxtMyInvoice;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UILabel *lblCity;
@property (nonatomic, retain) IBOutlet UIButton *btnShowMessageCount;
@property (nonatomic, retain) IBOutlet UIButton *btnExist;

@property (nonatomic, retain) IBOutlet UIImageView *userImage;

@property (nonatomic, retain) IBOutlet UILabel *langTxtMyInfo;
@property (nonatomic, retain) IBOutlet UILabel *lblChild;
@property (nonatomic, retain) IBOutlet UILabel *langTxtPassword;
@property (nonatomic, retain) IBOutlet UILabel *langTxtMyFavorite;
@property (nonatomic, retain) IBOutlet UILabel *langTxtMyComment;
@property (nonatomic, retain) IBOutlet UILabel *langTxtMyAddress;
@property (nonatomic, retain) IBOutlet UILabel *langTxtMyInvoice;

@end
