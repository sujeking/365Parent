//
//  MainViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface MainViewController : UIViewController<ImagePlayerViewDelegate,MAMapViewDelegate,AMapSearchDelegate,CLLocationManagerDelegate,IChatManagerDelegate, EMCallManagerDelegate>{
    
    UIScrollView *scrollView;
    
    ImagePlayerView *imagePlayerView;
    NSMutableArray *imageURLs;
    NSMutableArray *openURLs;
    NSMutableArray *titles;
    
    UIButton *btnMenu1;
    UIButton *btnMenu2;
    UIButton *btnMenu3;
    UIButton *btnMenu4;
    UIButton *btnMenu5;
    UIButton *btnMenu6;
    UIButton *btnMessage1;
    UIButton *btnMessage2;
    UIButton *btnMessage3;
    UIButton *btnMessage4;
    UIButton *btnMessage5;
    
    UIImageView *userHeadImage;
    UIButton *btnLogo;


    NSString *getCurrentLocationCity;//获取当前定位城市
    BOOL setLocation;//定位开关
    CLLocationManager *locationManager;
    
    NSString *setTitle;
    NSString *setType;
    NSString *setMapURL;
    
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UIButton *btnMenu1;
@property (nonatomic, retain) IBOutlet UIButton *btnMenu2;
@property (nonatomic, retain) IBOutlet UIButton *btnMenu3;
@property (nonatomic, retain) IBOutlet UIButton *btnMenu4;
@property (nonatomic, retain) IBOutlet UIButton *btnMenu5;
@property (nonatomic, retain) IBOutlet UIButton *btnMenu6;
@property (nonatomic, retain) IBOutlet UIButton *btnMessage1;
@property (nonatomic, retain) IBOutlet UIButton *btnMessage2;
@property (nonatomic, retain) IBOutlet UIButton *btnMessage3;
@property (nonatomic, retain) IBOutlet UIButton *btnMessage4;
@property (nonatomic, retain) IBOutlet UIButton *btnMessage5;

@property (nonatomic, retain) IBOutlet UIImageView *userHeadImage;
@property (nonatomic, retain) IBOutlet UIButton *btnLogo;

@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
@property (nonatomic, strong) NSMutableArray *imageURLs;
@property (nonatomic, strong) NSMutableArray *openURLs;
@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

- (void)addLogString:(NSString *)logStr;

@end
