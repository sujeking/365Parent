//
//  MainViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2014-12-05
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "MainViewController.h"

#import "OnlineViewController.h"
#import "SuperParentViewController.h"
#import "SNSViewController.h"
#import "SettingViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
#import "MeViewController.h"
#import "QuestionListViewController.h"
#import "TabsViewController.h"
#import "InfoListNewViewController.h"
#import "FeedbackViewController.h"
#import "BindSelectViewController.h"
#import "FeedbackViewController.h"

#import "HXLoginViewController.h"
#import "HXMainViewController.h"
#import "ContactsViewController.h"
#import "ChatViewController.h"
#import "RobotManager.h"
#import "SDCycleScrollView.h"


#import "Common.h"
#import "Config.h"
#import "ParseJson.h"
#import "DataSource.h"
#import "GRAlertView.h"
#import "InternationalControl.h"

//高德地图
#import "ReGeocodeAnnotation.h"
#import "APIKey.h"

#import <SDWebImage/UIImageView+WebCache.h>


/* web start */
#import "TOWebViewController.h"

#ifndef NSFoundationVersionNumber_iOS_6_1
#define NSFoundationVersionNumber_iOS_6_1  993.00
#endif

/* Detect if we're running iOS 7.0 or higher */
#define MINIMAL_UI (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
/* web end */

//动画
static NSString * const AnimationKey = @"animationKey";
#define kDuration 0.7   // 动画持续时间(秒)

#import "BPush.h"


@interface MainViewController () <SDCycleScrollViewDelegate>

@end

@implementation MainViewController
@synthesize imagePlayerView;
@synthesize imageURLs;
@synthesize mapView;
@synthesize search;
@synthesize openURLs;
@synthesize scrollView;
@synthesize btnMenu1;
@synthesize btnMenu2;
@synthesize btnMenu3;
@synthesize btnMenu4;
@synthesize btnMenu5;
@synthesize btnMenu6;
@synthesize btnMessage1;
@synthesize btnMessage2;
@synthesize btnMessage3;
@synthesize btnMessage4;
@synthesize btnMessage5;
@synthesize btnLogo;
@synthesize userHeadImage;
@synthesize titles;
    
- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    //[self.mapView removeAnnotations:self.mapView.annotations];
    //[self.mapView removeOverlays:self.mapView.overlays];
    self.mapView.delegate = nil;
}

- (void)clearSearch
{
    self.search.delegate = nil;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self clearMapView];
    [self clearSearch];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
        scrollView.contentSize = CGSizeMake(320,580);
    }
    else{
        scrollView.contentSize = CGSizeMake(320,580 + 100);
    }
    
    //处理城市
    NSString *getSelectedCity = nil;
    NSString *getLocationCity = nil;
    NSString *getLocationAddress = nil;
    NSString *flagShowMessage = nil;
    NSString *flagShowBack = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        
        flagShowBack = [defaults objectForKey:@"cloudin_365paxy_flag_showback"];
        flagShowMessage = [defaults objectForKey:@"cloudin_365paxy_message_exit"];
        getSelectedCity = [defaults objectForKey:@"cloudin_365paxy_selectedcity"];
        getLocationCity = [defaults objectForKey:@"cloudin_365paxy_location_city"];
        getLocationAddress = [defaults objectForKey:@"cloudin_365paxy_address"];
        if (getSelectedCity == nil) {
            if (getLocationCity == nil) {
                getLocationCity = DefaultCity;
            }
            getSelectedCity = getLocationCity;
        }
        
        if (getLocationAddress==nil || [getLocationAddress isEqual:[NSNull null]] || [getLocationAddress isEqualToString:@"(null)"]) {
            getLocationAddress = @"定位失败，请检查GPS是否开启";
        }
        //[self setCity:getSelectedCity];定位城市时用，暂时作废
        
        NSLog(@"address=%@",getLocationAddress);

    }
    
    //开启定位
    self.mapView.showsUserLocation = YES;//YES开启，NO关闭

    //动画效果
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.1];
    shake.toValue = [NSNumber numberWithFloat:+0.1];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 4;
    [self.btnLogo.layer addAnimation:shake forKey:@"imageView"];
    self.btnLogo.alpha = 1.0;
    [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:nil];
    
    
    NSString *getImgURL = [defaults objectForKey:@"cloudin_365paxy_head_image"];
    if ([getImgURL rangeOfString:@".png"].location !=NSNotFound) {
        getImgURL = [getImgURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
    }
    else if ([getImgURL rangeOfString:@".jpg"].location !=NSNotFound) {
        getImgURL = [getImgURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
    }
    //显示图片
    if (getImgURL != nil) {
        
        NSString *getHeadImageURL = getImgURL;
        [self.userHeadImage setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                       placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   //加载图片及指示器效果
                                   if (!activityIndicator) {
                                       [userHeadImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                       activityIndicator.center = userHeadImage.center;
                                       [activityIndicator startAnimating];
                                   }
                               } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                   //清除指示器效果
                                   [activityIndicator removeFromSuperview];
                                   activityIndicator = nil;
                               }];
        userHeadImage.layer.masksToBounds = YES;
        userHeadImage.layer.cornerRadius = 15.0;
        
       
    }

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    userHeadImage.userInteractionEnabled = YES;
    [userHeadImage addGestureRecognizer:gesture];
}

//处理单指事件
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSString *getUserID = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    //YES=隐藏，NO=显示
    [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_username"];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_me"];
    
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        
        //MeViewController
        //HXLoginViewController
        //HXMainViewController
        MeViewController *nextController = [MeViewController alloc];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }
}


//显示弹出消息
-(void)showPopMessage:(NSString *)message
{
    //如果放在有TableView的页面，MBProgressHUD必须自定义变量，不能采用HUD全局变量，会冲突
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_365paxy_message_exit"];
}

- (void)setCity:(NSString *)getSelectedCity
{
    getSelectedCity = [getSelectedCity stringByReplacingOccurrencesOfString:@"省" withString:@""];
    getSelectedCity = [getSelectedCity stringByReplacingOccurrencesOfString:@"市" withString:@""];
    getSelectedCity = [getSelectedCity stringByReplacingOccurrencesOfString:@"镇" withString:@""];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = WhiteBgColor;
    
    
    //加载广告区域
    imagePlayerView = [[ImagePlayerView alloc] init];
    imagePlayerView.frame = CGRectMake(0, 0, 320, 150);
    UIImage *backgroundImage = [[UIImage alloc] init];
    backgroundImage = [UIImage imageNamed:@"default_image_320_150.png"];
    imagePlayerView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    //[self.scrollView addSubview:imagePlayerView];
    
    [NSThread detachNewThreadSelector:@selector(loadAdsData) toTarget:self withObject:nil];
    
    
    //高德地图定位
    self.mapView = [[MAMapView alloc] init];
    self.mapView.delegate = self;
    //search = [[AMapSearchAPI alloc] initWithSearchKey: (NSString *)APIKey Delegate:self];
    search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    setLocation = YES;
    
    NSString *appid =  [BPush getAppId];
    NSString *userid =  [BPush getUserId];
    NSString *channelid =  [BPush getChannelId];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:appid forKey:@"cloudin_365paxy_push_appid"];
    [defaults setObject:userid forKey:@"cloudin_365paxy_push_userid"];
    [defaults setObject:channelid forKey:@"cloudin_365paxy_push_channelid"];
    NSLog(@"Push AppID=%@,UserID=%@,ChannelID=%@",appid,userid,channelid);
    
    btnMessage1.hidden = TRUE;
    btnMessage2.hidden = TRUE;
    btnMessage3.hidden = TRUE;
    btnMessage4.hidden = TRUE;
    btnMessage5.hidden = TRUE;
    
    
    //加载消息
    //[self getMessageNum];
    //[self performSelectorOnMainThread:@selector(getMessageNum) withObject:nil waitUntilDone:NO];

}


//加载广告
- (void)loadAdsData
{
    @try {
        
        imageURLs = [[NSMutableArray alloc] init];
        openURLs = [[NSMutableArray alloc] init];
        
        //从服务端获取广告
        NSString *urlString = [NSString stringWithFormat:@"%@?flag=1",AdsListUrl];
        NSLog(@"URL=%@",urlString);
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"List"];
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getImage = [statusDict objectForKey:@"AdsImage"];
            NSString *getURL = [statusDict objectForKey:@"AdsURL"];
            NSString *getAdsTitle = [statusDict objectForKey:@"AdsTitle"];
            //NSString *getAdsType = [statusDict objectForKey:@"AdsType"];
            //NSString *getNewsID = [statusDict objectForKey:@"NewsID"];

            [self.imageURLs addObject:getImage];
            [self.openURLs addObject:getURL];//[NSURL URLWithString:getURL]
            [self.titles addObject:getAdsTitle];
        }
        
        CGFloat w = self.view.bounds.size.width;
        
        //网络加载 --- 创建带标题的图片轮播器
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 150) imageURLStringsGroup:nil]; // 模拟网络延时情景
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.delegate = self;
        cycleScrollView.titlesGroup = titles;
        cycleScrollView.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
        cycleScrollView.placeholderImage = [UIImage imageNamed:@"default_image_320_150"];
        cycleScrollView.autoScrollTimeInterval = 3.0;
        [self.scrollView addSubview:cycleScrollView];
        
        // 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView.imageURLStringsGroup = imageURLs;
        });
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (index == 0) {
        //信息中心
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //YES=隐藏，NO=显示
        [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
        
        [self gotoTabs:@"信息中心" ItemIndex:0];
    }
    else if(index == 1){
        //365在线
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults)
        {
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        //YES=隐藏，NO=显示
        [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
        
        if (getUserID.length==0) {
            //未登陆
            LoginViewController *nextController = [[LoginViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
            [self presentViewController:navigationController animated:YES completion:^{
                //
            }];
            [nextController release];
            [navigationController release];
        }
        else{
            
            [defaults setObject:@"4" forKey:@"cloudin_365paxy_news_type"];
            [defaults setObject:@"0" forKey:@"cloudin_365paxy_news_flag"];
            
            [self gotoTabs:@"365在线" ItemIndex:1];
        }
    }
    else if(index == 2){
        //家校互动
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults)
        {
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        //YES=隐藏，NO=显示
        [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
        
        if (getUserID.length==0) {
            //未登陆
            LoginViewController *nextController = [[LoginViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
            [self presentViewController:navigationController animated:YES completion:^{
                //
            }];
            [nextController release];
            [navigationController release];
        }
        else{
            [self gotoTabs:@"家校互动" ItemIndex:2];
        }
    }
    else if(index == 3){
        //平台介绍
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //YES=隐藏，NO=显示
        [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
        
        NSString *getURL = [self.openURLs objectAtIndex:index];
        getURL = [NSString stringWithFormat:@"%@",getURL];
        //NSLog(@"URL=%@",getURL);
        WebViewController *vc = [WebViewController alloc];
        vc.setTitle = AppName;
        vc.setURL = getURL;
        vc.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(index == 4){
        //APP意见反馈
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //YES=隐藏，NO=显示
        [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
        
        FeedbackViewController *nextController = [[FeedbackViewController alloc] init];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
    }
    
    //NSLog(@"---点击了第%ld张图片", index);
}



/*
 以下为高德地图定位及逆地理位置
 */

//实时获取定位的经纬度
-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if (setLocation) {
        NSNumber *getLat =[NSNumber numberWithDouble:userLocation.location.coordinate.latitude];
        NSNumber *getLng =[NSNumber numberWithDouble:userLocation.location.coordinate.longitude];
        NSLog(@"lat=%@,lng=%@",getLat,getLng);
        NSString *getFlag = [NSString stringWithFormat:@"%@",getLat];
        if (![getFlag isEqualToString:@"0"]) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:getLat forKey:@"cloudin_365paxy_lat"];
            [defaults setObject:getLng forKey:@"cloudin_365paxy_lng"];
            
            [self searchReGeocodeWithCoordinate:userLocation.location.coordinate];
            setLocation = NO;
            NSLog(@"location = stop");
        }
        else{
            NSLog(@"location = start");
        }
        
    }
    
}

//定位失败时抛出消息
-(void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error
{
    NSLog(@"location error=%@",[NSString stringWithFormat:@"%@",error]);
}


//逆地理编码
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}


#pragma mark - AMapSearchDelegate

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
                                                                                         reGeocode:response.regeocode];
        
        [self.mapView addAnnotation:reGeocodeAnnotation];
        [self.mapView selectAnnotation:reGeocodeAnnotation animated:YES];
        
        NSString *getAddress = response.regeocode.formattedAddress;
        //读取详细地址信息
        AMapAddressComponent *addressComponent = response.regeocode.addressComponent;
        NSString *getProvince =  addressComponent.province;
        NSString *getCity =  addressComponent.city;
        //NSString *getDistrict =  addressComponent.district;
        //NSString *getTownShip =  addressComponent.township;
        //NSString *getNeighborhood =  addressComponent.neighborhood;
        //NSString *getBuilding =  addressComponent.building;
        //NSString *getCityCode =  addressComponent.citycode;
        //NSString *getAdCode =  addressComponent.adcode;
        NSString *getStreet =  [addressComponent.streetNumber street];
        //NSString *getNumber =  [addressComponent.streetNumber number];
        //NSString *getDistance =  [addressComponent.streetNumber distance];
        //NSString *getDirection =  [addressComponent.streetNumber direction];
        
        if (getCity == nil || getCity.length==0) {
            getCity = getProvince;
        }
        
        NSLog( @"address=%@,city=%@,street=%@",getAddress,getCity,getStreet);
        getCurrentLocationCity = getCity;

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:getAddress forKey:@"cloudin_365paxy_address"];
        [defaults setObject:getCity forKey:@"cloudin_365paxy_city"];
        //[defaults setObject:locationStreet forKey:@"cloudin_365paxy_street"];
        
        //判断定位城市与默认城市是否一致，如果不一致，则弹出提示框，是否切换
        //NSString *message = [NSString stringWithFormat:@"是否切换到当前定位城市：%@",getCity];
        NSString *getLocationCity = [defaults objectForKey:@"cloudin_365paxy_location_city"];
        if (getLocationCity==nil || getLocationCity.length==0) {
            getLocationCity = DefaultCity;
        }
        if (![getCity isEqualToString:getLocationCity]) {
            //[self showDialogMessage:message];//暂时关闭弹窗
        }else{
            [self setCity:getCity];
        }
    }
}

- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}

//弹出消息对话框
- (void)showDialogMessage:(NSString *)message
{
    GRAlertView *alert;
    alert = [[GRAlertView alloc] initWithTitle:@"提醒"
                                       message:message
                                      delegate:self
                             cancelButtonTitle:@"取消"
                             otherButtonTitles:@"确定", nil];
    
    [alert setTopColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           middleColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]
           bottomColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]             lineColor:[UIColor colorWithRed:153/255.0 green:206/255.0 blue:0/255.0 alpha:1.0]];
    
    
    [alert setFontName:@"Cochin-Bold"
             fontColor:[UIColor colorWithRed:225/255.0 green:225/255.0 blue:226/255.0 alpha:1.0]
       fontShadowColor:[UIColor colorWithRed:110/255.0 green:111/255.0 blue:114/255.0 alpha:1.0]];
    
    //[alert setImage:@"login_icon.png"];
    alert.animation = GRAlertAnimationNone;
    [alert show];
}

//处理弹出框动作
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //NSLog(@"Button pushed: %@, index %i", alertView.title, buttonIndex);
    if (buttonIndex == 1) {
        
        if (getCurrentLocationCity ==nil || getCurrentLocationCity.length==0) {
            getCurrentLocationCity = DefaultCity;
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:getCurrentLocationCity forKey:@"cloudin_365paxy_city"];
        [defaults setObject:getCurrentLocationCity forKey:@"cloudin_365paxy_location_city"];
        
        [self setCity:getCurrentLocationCity];
    }
    else{
        //取消
    }
}

//信息中心
- (IBAction) btnMenus1Pressed: (id) sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //YES=隐藏，NO=显示
    [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];

    [self gotoTabs:@"信息中心" ItemIndex:0];
}

//365在线
- (IBAction) btnMenus2Pressed: (id) sender
{
    NSString *getUserID = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    //YES=隐藏，NO=显示
    [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        
        [defaults setObject:@"4" forKey:@"cloudin_365paxy_news_type"];
        [defaults setObject:@"0" forKey:@"cloudin_365paxy_news_flag"];
    
        [self gotoTabs:@"365在线" ItemIndex:1];
    }
}

//家校互动
- (IBAction) btnMenus3Pressed: (id) sender
{
    
    
    NSString *getUserID = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    //YES=隐藏，NO=显示
    [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
         [self gotoTabs:@"家校互动" ItemIndex:2];
    }
}

//问卷调查
- (IBAction) btnMenus4Pressed: (id) sender
{
    NSString *getUserID = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    //YES=隐藏，NO=显示
    [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        
        [defaults setObject:@"1" forKey:@"cloudin_365paxy_question_flag"];
        [defaults setObject:@"1" forKey:@"cloudin_365paxy_question_type"];
        [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_flag"];
        [defaults setObject:@"word" forKey:@"cloudin_365paxy_nodata_show_sflag"];
        [defaults setObject:@"暂时没有数据" forKey:@"cloudin_365paxy_nodata_show_word"];
        
        QuestionListViewController *nextController = [QuestionListViewController alloc];
        [nextController sendGetDatas];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];
        
    }
}


//超级家长
- (IBAction) btnMenus5Pressed: (id) sender
{
    NSString *getUserID = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults)
    {
        getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
    }
    
    //YES=隐藏，NO=显示
    [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
    
    if (getUserID.length==0) {
        //未登陆
        LoginViewController *nextController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:nextController];
        [self presentViewController:navigationController animated:YES completion:^{
            //
        }];
        [nextController release];
        [navigationController release];
    }
    else{
        
        /*
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //YES=隐藏，NO=显示
        [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
        
        NSString *getURL = ParentMenu1Url;
        getURL = [NSString stringWithFormat:@"%@",getURL];
        //NSLog(@"URL=%@",getURL);
        WebViewController *vc = [WebViewController alloc];
        vc.setTitle =  @"超级家长";
        vc.setURL = getURL;
        vc.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:vc animated:YES];*/
        
        FeedbackViewController *nextController = [[FeedbackViewController alloc] init];
        nextController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBarHidden = FALSE;
        [self.navigationController pushViewController:nextController animated:YES];
        [nextController release];

    }
}


- (IBAction) btnLogoPressed: (id) sender
{
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //YES=隐藏，NO=显示
    [defaults setObject:@"YES" forKey:@"cloudin_365paxy_return_showback"];
    
    //NSURL *url = [NSURL URLWithString:WebsiteUrl];
    //TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
    //[self.navigationController pushViewController:webViewController animated:YES];
    
    //NSString *getURL = [self.openURLs objectAtIndex:index];
    //getURL = [NSString stringWithFormat:@"%@",WebsiteUrl];
    //NSLog(@"URL=%@",getURL);
    WebViewController *vc = [WebViewController alloc];
    vc.setTitle = AppName;
    vc.setURL = WebsiteUrl;
    vc.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];*/
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_goto_flag"];
    
    BindSelectViewController *vc = [BindSelectViewController alloc];
     vc.setTitle = @"选择班级";
    [vc sendGetDatas];
    self.navigationController.navigationBarHidden = FALSE;
    [self.navigationController pushViewController:vc animated:YES];

}

//拨打客服热线
- (IBAction) btnPhonePressed: (id) sender
{
    NSString *number = @"09914322638";

    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}

-(void)gotoTabs:(NSString *)Title ItemIndex:(int)index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"cloudin_365paxy_click_type"];
    
    if(index==0 ){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"2" forKey:@"cloudin_365paxy_news_type"];
        [defaults setObject:@"0" forKey:@"cloudin_365paxy_news_flag"];
        [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_flag"];
        [defaults setObject:@"image" forKey:@"cloudin_365paxy_nodata_show_sflag"];
        [defaults setObject:@"250" forKey:@"cloudin_365paxy_nodata_flag"];

    }
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    InfoListNewViewController *vc1 = [[InfoListNewViewController alloc] init];
    [vc1 sendGetDatas];
    [vc1 setTitle:@"信息中心"];
    [vc1.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabs_menu1_cur.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabs_menu1.png"]];
    [vc1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextDefaultColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateNormal];
    [vc1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextCurrentColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateSelected];
    [items addObject:vc1];
    
    
    OnlineViewController *vc2 = [[OnlineViewController alloc] init];
    [vc2 setTitle:@"365在线"];
    [vc2.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabs_menu2_cur.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabs_menu2.png"]];
    [vc2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextDefaultColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateNormal];
    [vc2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextCurrentColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateSelected];

    [items addObject:vc2];
    
    
    SNSViewController *vc3 = [[SNSViewController alloc] init];
    [vc3 setTitle:@"家校互动"];
    [vc3.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabs_menu3_cur.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabs_menu3.png"]];
    [vc3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextDefaultColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateNormal];
    [vc3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextCurrentColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateSelected];
    [items addObject:vc3];
    
    SuperParentViewController *vc4 = [[SuperParentViewController alloc] init];
    [vc4 setTitle:@"意见反馈"];
    [vc4.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabs_menu4_cur.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabs_menu4.png"]];
    [vc4.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextDefaultColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateNormal];
    [vc4.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        TabbarTextCurrentColor, UITextAttributeTextColor,
                                                        nil] forState:UIControlStateSelected];
    [items addObject:vc4];
    
    // items是数组，每个成员都是UIViewController
    TabsViewController *tabBar = [[TabsViewController alloc] init];
    [tabBar setTitle:@"TabBarController"];
    [tabBar setViewControllers:items];
    [tabBar setSelectedIndex:index];//默认索引位置
    [tabBar setTitle:@"365平安在线"];//标题名称
    self.navigationController.navigationBarHidden = TRUE;    
    [self.navigationController pushViewController:tabBar animated:YES];

}


- (void)addLogString:(NSString *)logStr
{
    logStr = [self replaceUnicode:logStr];
    NSString *additionStr = [logStr stringByAppendingString:@"\n\n"];
    //NSString *preLogString = self.outputTextView.text;
    //if (preLogString) {
        //[self.outputTextView setText:[additionStr stringByAppendingString:preLogString]];
    //}else
    //{
        //[self.outputTextView setText:additionStr];
    //}
    NSLog(@"BaiduPush：%@",additionStr);
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}


//获取提醒消息数量
- (void)getMessageNum
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&uid=%@&flag=0",CountMessageNumUrl,getUserID];
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSLog(@"URL=%@",urlString);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *loginStatus = [loginDict objectForKey:@"Results"];
        NSLog(@"Count=%lu",(unsigned long)[loginStatus count]);
        for (int i = 0; i < [loginStatus count]; i ++) {
            
            NSDictionary *statusDict = [loginStatus objectAtIndex:i];
            NSString *getStatus = [statusDict objectForKey:@"Status"];
            NSString *getCountInfo = [statusDict objectForKey:@"CountInfo"];
            NSString *getCount365 = [statusDict objectForKey:@"Count365"];
            NSString *getCountSNS = [statusDict objectForKey:@"CountSNS"];
            NSString *getCountQuestion = [statusDict objectForKey:@"CountQuestion"];
            NSString *getCountParent = [statusDict objectForKey:@"CountParent"];
            
            if ([getCountInfo isEqualToString:@"0"]) {
                btnMessage1.hidden = TRUE;
            }
            else{
                btnMessage1.hidden = FALSE;
                [btnMessage1 setTitle:getCountInfo forState:UIControlStateNormal];
            }
            
            if ([getCount365 isEqualToString:@"0"]) {
                btnMessage2.hidden = TRUE;
            }
            else{
                btnMessage2.hidden = FALSE;
                [btnMessage2 setTitle:getCount365 forState:UIControlStateNormal];
            }
            
            if ([getCountSNS isEqualToString:@"0"]) {
                btnMessage3.hidden = TRUE;
            }
            else{
                btnMessage3.hidden = FALSE;
                [btnMessage3 setTitle:getCountSNS forState:UIControlStateNormal];
            }
            
            if ([getCountQuestion isEqualToString:@"0"]) {
                btnMessage4.hidden = TRUE;
            }
            else{
                btnMessage4.hidden = FALSE;
                [btnMessage4 setTitle:getCountQuestion forState:UIControlStateNormal];
            }
            
            if ([getCountParent isEqualToString:@"0"]) {
                btnMessage5.hidden = TRUE;
            }
            else{
                btnMessage5.hidden = FALSE;
                [btnMessage5 setTitle:getCountParent forState:UIControlStateNormal];
            }
            
            NSLog(@"Status=%@",getStatus);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void) dealloc
{
    [super dealloc];
}


@end
