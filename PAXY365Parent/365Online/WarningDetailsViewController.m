//
//  WarningDetailsViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/17.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "WarningDetailsViewController.h"

#import "WarningMapViewController.h"

#import "Common.h"
#import "Config.h"
#import "ParseJson.h"
#import "GPRoundView.h"
#import "DataSource.h"

//高德地图
#import "ReGeocodeAnnotation.h"
#import "APIKey.h"
#import "CusAnnotationView.h"

#import <SDWebImage/UIImageView+WebCache.h>

#define kCalloutViewMargin          -8

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

enum {
    AnnotationViewControllerAnnotationTypeRed = 0,
    AnnotationViewControllerAnnotationTypeGreen,
    AnnotationViewControllerAnnotationTypePurple
};

//地图
#define MACircle  [UIColor colorWithRed:57/255.0 green:187/255.0 blue:255/255.0 alpha:0.3];

@interface WarningDetailsViewController()

@property (nonatomic, strong) NSMutableArray *annotations;

@end

@implementation WarningDetailsViewController
@synthesize setTitle;
@synthesize setType;
@synthesize search;
@synthesize warningEntity;
@synthesize lblName;
@synthesize lblDistance;
@synthesize lblDate;
@synthesize lblDesc;
@synthesize lblTitle;
@synthesize lblClickNum;
@synthesize scrollView;
@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView5;
@synthesize imageView4;
@synthesize imageView3;
@synthesize headImage;
@synthesize activityIndicator;
@synthesize annotations = _annotations;


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //根据上传图片的数量来判断页面高度
    int height = 0;
    NSString *getImageURLs = warningEntity.ImagesList;
    arrayURL = [getImageURLs componentsSeparatedByString:@"|"];
//    if ([arrayURL count]==0) {
//        height = 0;
//    }
//    if ([arrayURL count]==1) {
//        height = 200;
//    }
//    if ([arrayURL count]==2) {
//        height = 400;
//    }
//    if ([arrayURL count]==3) {
//        height = 600;
//    }
//    if ([arrayURL count]==4) {
//        height = 800;
//    }
//    if ([arrayURL count]==5) {
//        height = 1000;;
//    }
    
    height=CGRectGetHeight(self.imageView1.bounds)*arrayURL.count;

    
    
    if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
        
//        scrollView.contentSize = CGSizeMake(320,600 + height);
        self.scrollView.contentSize = CGSizeMake(320,CGRectGetHeight(self.view.bounds)-64 + height);
    }
    else{
//        scrollView.contentSize = CGSizeMake(320,600 + height + 100);
        self.scrollView.contentSize = CGSizeMake(320,CGRectGetHeight(self.view.bounds)-64 + height);
    }
    
    [self.mapView addAnnotations:self.annotations];
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor                     = [self.annotations indexOfObject:annotation];
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Initialization

- (void)initAnnotations
{
    self.annotations = [NSMutableArray array];
    
    NSString *getLat = warningEntity.SafeLat;
    NSString *getLng = warningEntity.SafeLng;
    NSString *getTitle = warningEntity.SafeAddress;
    
    NSLog(@"lat2=%@,lng2=%@",getLat,getLng);
    
    CLLocationCoordinate2D center = {[getLat floatValue],[getLng floatValue]};
    
    /* Red annotation. */
    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
    red.coordinate = center;
    red.title      = getTitle;
    [self.annotations insertObject:red atIndex:AnnotationViewControllerAnnotationTypeRed];
   
    
    [self.mapView setCenterCoordinate:center animated:YES];
    
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = WhiteBgColor;
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = setTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    // back button
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    NSString *getUserID = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults)
    {
        getUserID = [standardUserDefaults objectForKey:@"cloudin_365paxy_uid"];
        if ([getUserID isEqualToString:warningEntity.UserID]) {
            
            //显示删除按钮
            UIImage *saveImage = [UIImage imageNamed: @"btn_box_bg.png"];
            UIView *containingSaveView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, saveImage.size.width, saveImage.size.height)] autorelease];
            UIButton *saveUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [saveUIButton setBackgroundImage:saveImage forState:UIControlStateNormal];
            [saveUIButton setTitle:@"删除" forState:UIControlStateNormal];
            [saveUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            saveUIButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            saveUIButton.frame = CGRectMake(0, 0, 60, saveImage.size.height);
            [saveUIButton addTarget:self action:@selector(delData) forControlEvents:UIControlEventTouchUpInside];
            [containingSaveView addSubview:saveUIButton];
            UIBarButtonItem *containingSaveButton = [[[UIBarButtonItem alloc] initWithCustomView:containingSaveView] autorelease];
            self.navigationItem.rightBarButtonItem = containingSaveButton;
        }
    }
    
   
    
    
    //高德地图定位
    self.mapView.frame = self.view.bounds;
    //self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,0,320,500)];
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(10,222,300,120)];
    self.mapView.delegate = self;
    [self.mapView setZoomLevel: 14 animated:YES];
    [self.scrollView addSubview:self.mapView];
    
    [self initAnnotations];
    
    //开启定位
    self.mapView.showsUserLocation = NO;//YES开启，NO关闭
    self.mapView.userTrackingMode  = MAUserTrackingModeNone;
    
    
    //读取数据
    lblTitle.text = warningEntity.SafeTitle;
    NSString *getAddress = warningEntity.SafeAddress;
    if (getAddress.length<=0||[getAddress isEqualToString:@"(null)"]) {
        getAddress = @"保密";
    }

    [self setdistanseLabelFrameWith:[NSString stringWithFormat:@"%@",getAddress]];
    lblDistance.textColor = TxtBlue;
    
    lblDate.text = warningEntity.AddDate;
    lblDate.textColor = TxtLightGray;
    
    lblName.text = warningEntity.SchoolInfo;
    lblDesc.text = warningEntity.SafeDesc;
    lblDesc.textColor = TxtLightBlack;
    
    lblClickNum.text = [NSString stringWithFormat:@"%@浏览",warningEntity.ClickNum];
    lblClickNum.textColor = TxtGray;
    lblClickNum.backgroundColor = TxtLightGray2;
    
    /*
    //头像
    NSString *getHeadImage = warningEntity.UserImage;
    if ([getHeadImage rangeOfString:@".png"].location !=NSNotFound) {
        getHeadImage = [getHeadImage stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
    }
    else if ([getHeadImage rangeOfString:@".jpg"].location !=NSNotFound) {
        getHeadImage = [getHeadImage stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
    }
    [self.headImage setImageWithURL:[NSURL URLWithString:getHeadImage]
                    placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                //加载图片及指示器效果
                                if (!activityIndicator) {
                                    [headImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                    activityIndicator.center = headImage.center;
                                    [activityIndicator startAnimating];
                                }
                            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                //清除指示器效果
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                            }];

    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = 5.0;
    
    //图片实际大小：UIViewContentModeScaleAspectFit；在指定区域内拉伸填充UIViewContentModeScaleToFill；超出区域拉伸UIViewContentModeScaleAspectFill
    headImage.contentMode = UIViewContentModeScaleAspectFit;*/
    
    //图片组
    NSString *getImageURL1 = nil;
    NSString *getImageURL2 = nil;
    NSString *getImageURL3 = nil;
    NSString *getImageURL4 = nil;
    NSString *getImageURL5 = nil;
    NSString *getImageURLs = warningEntity.ImagesList;
    NSLog(@"URLs: %@",getImageURLs);
    arrayURL = [getImageURLs componentsSeparatedByString:@"|"];
    NSLog(@"count: %lu",(unsigned long)[arrayURL count]);
    

    switch (arrayURL.count) {
        case 0:
            [imageView1 removeFromSuperview];
            [imageView2 removeFromSuperview];
            [imageView3 removeFromSuperview];
            [imageView4 removeFromSuperview];
            [imageView5 removeFromSuperview];
            break;
        case 1:
            if ([getImageURL1 isEqualToString:@"http://img.365paxy.org.cn/no_img.png"]) {
                [imageView1 removeFromSuperview];
            }
            getImageURL1 =  arrayURL[0];
            [imageView2 removeFromSuperview];
            [imageView3 removeFromSuperview];
            [imageView4 removeFromSuperview];
            [imageView5 removeFromSuperview];
            break;
        case 2:
            getImageURL1 =  arrayURL[0];
            getImageURL2 =  arrayURL[1];
            [imageView3 removeFromSuperview];
            [imageView4 removeFromSuperview];
            [imageView5 removeFromSuperview];
            break;
        case 3:
            getImageURL1 =  arrayURL[0];
            getImageURL2 =  arrayURL[1];
            getImageURL3 =  arrayURL[2];
            
            [imageView4 removeFromSuperview];
            [imageView5 removeFromSuperview];
            break;
        case 4:
            getImageURL1 =  arrayURL[0];
            getImageURL2 =  arrayURL[1];
            getImageURL3 =  arrayURL[2];
            getImageURL4 =  arrayURL[3];
            [imageView5 removeFromSuperview];
            break;
        case 5:
            getImageURL1 =  arrayURL[0];
            getImageURL2 =  arrayURL[1];
            getImageURL3 =  arrayURL[2];
            getImageURL4 =  arrayURL[3];
            getImageURL5 =  arrayURL[4];
            break;
        default:
            break;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    
    if ([arrayURL count]==1) {
        //1张
        
        imageView1.hidden = FALSE;
        imageView2.hidden = TRUE;
        imageView3.hidden = TRUE;
        imageView4.hidden = TRUE;
        imageView5.hidden = TRUE;
        
        getImageURL1 =  arrayURL[0];
        if ([getImageURL1 isEqualToString:@"http://img.365paxy.org.cn/no_img.png"]) {
            imageView1.hidden = TRUE;
        }

    }
    if ([arrayURL count]==2) {
        //2张
        getImageURL1 =  arrayURL[0];
        getImageURL2 =  arrayURL[1];
        imageView1.hidden = FALSE;
        imageView2.hidden = FALSE;
        imageView3.hidden = TRUE;
        imageView4.hidden = TRUE;
        imageView5.hidden = TRUE;
        
    }
    if ([arrayURL count]==3) {
        //3张
        getImageURL1 =  arrayURL[0];
        getImageURL2 =  arrayURL[1];
        getImageURL3 =  arrayURL[2];
        imageView1.hidden = FALSE;
        imageView2.hidden = FALSE;
        imageView3.hidden = FALSE;
        imageView4.hidden = TRUE;
        imageView5.hidden = TRUE;

    }
    if ([arrayURL count]==4) {
        //4张
        getImageURL1 =  arrayURL[0];
        getImageURL2 =  arrayURL[1];
        getImageURL3 =  arrayURL[2];
        getImageURL4 =  arrayURL[3];
        imageView1.hidden = FALSE;
        imageView2.hidden = FALSE;
        imageView3.hidden = FALSE;
        imageView4.hidden = FALSE;
        imageView5.hidden = TRUE;
        
    }
    if ([arrayURL count]==5) {
        //5张
        getImageURL1 =  arrayURL[0];
        getImageURL2 =  arrayURL[1];
        getImageURL3 =  arrayURL[2];
        getImageURL4 =  arrayURL[3];
        getImageURL5 =  arrayURL[4];
        imageView1.hidden = FALSE;
        imageView2.hidden = FALSE;
        imageView3.hidden = FALSE;
        imageView4.hidden = FALSE;
        imageView5.hidden = FALSE;
        
    }
*/
   
    
    //1
    if ([getImageURL1 rangeOfString:@".png"].location !=NSNotFound) {
        getImageURL1 = [getImageURL1 stringByReplacingOccurrencesOfString:@".png" withString:@"_m.jpg"];
    }
    else if ([getImageURL1 rangeOfString:@".jpg"].location !=NSNotFound && [getImageURL1 rangeOfString:@"_m.jpg"].location !=NSNotFound) {
        getImageURL1 = [getImageURL1 stringByReplacingOccurrencesOfString:@".jpg" withString:@"_m.jpg"];
    }
    NSLog(@"getImageURL1:%@",getImageURL1);
    [self.imageView1 setImageWithURL:[NSURL URLWithString:getImageURL1]
                   placeholderImage:[UIImage imageNamed:@"default_image_320_200.png"] options:SDWebImageProgressiveDownload
                           progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                               //加载图片及指示器效果
                               if (!activityIndicator) {
                                   [imageView1 addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                   activityIndicator.center = imageView1.center;
                                   [activityIndicator startAnimating];
                               }
                           } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                               //清除指示器效果
                               [activityIndicator removeFromSuperview];
                               activityIndicator = nil;
                           }];
    imageView1.contentMode = UIViewContentModeScaleToFill;
    
    if (getImageURL1.length>0) {
        imageView1.tag = 0;
        imageView1.userInteractionEnabled = YES;
        [imageView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        imageView1.hidden = FALSE;
    }
    else{
        imageView1.hidden = TRUE;
    }
    
    
    //2
    if ([getImageURL2 rangeOfString:@".png"].location !=NSNotFound) {
        getImageURL2 = [getImageURL2 stringByReplacingOccurrencesOfString:@".png" withString:@"_m.jpg"];
    }
    else if ([getImageURL2 rangeOfString:@".jpg"].location !=NSNotFound && [getImageURL2 rangeOfString:@"_m.jpg"].location !=NSNotFound) {
        getImageURL2 = [getImageURL2 stringByReplacingOccurrencesOfString:@".jpg" withString:@"_m.jpg"];
    }
    [self.imageView2 setImageWithURL:[NSURL URLWithString:getImageURL2]
                    placeholderImage:[UIImage imageNamed:@"default_image_320_200.png"] options:SDWebImageProgressiveDownload
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                //加载图片及指示器效果
                                if (!activityIndicator) {
                                    [imageView2 addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                    activityIndicator.center = imageView2.center;
                                    [activityIndicator startAnimating];
                                }
                            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                //清除指示器效果
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                            }];
    imageView2.contentMode = UIViewContentModeScaleToFill;

    if (getImageURL2.length>0) {
        imageView2.tag = 1;
        imageView2.userInteractionEnabled = YES;
        [imageView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        imageView2.hidden = FALSE;
    }
    else{
        imageView2.hidden = TRUE;
    }
    
    //3
    if ([getImageURL3 rangeOfString:@".png"].location !=NSNotFound) {
        getImageURL3 = [getImageURL3 stringByReplacingOccurrencesOfString:@".png" withString:@"_m.jpg"];
    }
    else if ([getImageURL3 rangeOfString:@".jpg"].location !=NSNotFound && [getImageURL3 rangeOfString:@"_m.jpg"].location !=NSNotFound) {
        getImageURL3 = [getImageURL3 stringByReplacingOccurrencesOfString:@".jpg" withString:@"_m.jpg"];
    }
    [self.imageView3 setImageWithURL:[NSURL URLWithString:getImageURL3]
                    placeholderImage:[UIImage imageNamed:@"default_image_320_200.png"] options:SDWebImageProgressiveDownload
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                //加载图片及指示器效果
                                if (!activityIndicator) {
                                    [imageView3 addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                    activityIndicator.center = imageView3.center;
                                    [activityIndicator startAnimating];
                                }
                            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                //清除指示器效果
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                            }];
    
    imageView3.contentMode = UIViewContentModeScaleToFill;
    
    if (getImageURL3.length>0) {
        imageView3.tag = 2;
        imageView3.userInteractionEnabled = YES;
        [imageView3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        imageView3.hidden = FALSE;
    }
    else{
        imageView3.hidden = TRUE;
    }
    
    //4
    if ([getImageURL4 rangeOfString:@".png"].location !=NSNotFound) {
        getImageURL4 = [getImageURL4 stringByReplacingOccurrencesOfString:@".png" withString:@"_m.jpg"];
    }
    else if ([getImageURL4 rangeOfString:@".jpg"].location !=NSNotFound && [getImageURL4 rangeOfString:@"_m.jpg"].location !=NSNotFound) {
        getImageURL4 = [getImageURL4 stringByReplacingOccurrencesOfString:@".jpg" withString:@"_m.jpg"];
    }
    [self.imageView4 setImageWithURL:[NSURL URLWithString:getImageURL4]
                    placeholderImage:[UIImage imageNamed:@"default_image_320_200.png"] options:SDWebImageProgressiveDownload
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                //加载图片及指示器效果
                                if (!activityIndicator) {
                                    [imageView4 addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                    activityIndicator.center = imageView4.center;
                                    [activityIndicator startAnimating];
                                }
                            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                //清除指示器效果
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                            }];
    
    imageView4.contentMode = UIViewContentModeScaleToFill;
  
    if (getImageURL4.length>0) {
        imageView4.tag = 3;
        imageView4.userInteractionEnabled = YES;
        [imageView4 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        imageView4.hidden = FALSE;
    }
    else{
        imageView4.hidden = TRUE;
    }
    
    //5
    if ([getImageURL5 rangeOfString:@".png"].location !=NSNotFound) {
        getImageURL5 = [getImageURL5 stringByReplacingOccurrencesOfString:@".png" withString:@"_m.jpg"];
    }
    else if ([getImageURL5 rangeOfString:@".jpg"].location !=NSNotFound && [getImageURL5 rangeOfString:@"_m.jpg"].location !=NSNotFound) {
        getImageURL5 = [getImageURL5 stringByReplacingOccurrencesOfString:@".jpg" withString:@"_m.jpg"];
    }
    [self.imageView5 setImageWithURL:[NSURL URLWithString:getImageURL5]
                    placeholderImage:[UIImage imageNamed:@"default_image_320_200.png"] options:SDWebImageProgressiveDownload
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                //加载图片及指示器效果
                                if (!activityIndicator) {
                                    [imageView5 addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                    activityIndicator.center = imageView5.center;
                                    [activityIndicator startAnimating];
                                }
                            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                //清除指示器效果
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                            }];
    
    imageView5.contentMode = UIViewContentModeScaleToFill;

    if (getImageURL5.length>0) {
        imageView5.tag = 4;
        imageView5.userInteractionEnabled = YES;
        [imageView5 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        imageView5.hidden = FALSE;
    }
    else{
        imageView5.hidden = TRUE;
    }
    
      
    //[self performSelectorOnMainThread:@selector(loadMapsData) withObject:nil waitUntilDone:NO];//主线程
    
    [self updateWarningClickNum];
    
   // [self loadMapsData];
}

//根据文字设置显示的长度
- (void)setdistanseLabelFrameWith:(NSString*)text
{
//    self.lblDistance.numberOfLines=2;
//    CGSize size = [text sizeWithFont:self.lblDistance.font forWidth:CGRectGetWidth(self.lblDistance.bounds) lineBreakMode:NSLineBreakByWordWrapping];
//    
//    self.lblDistance.frame=CGRectMake(self.lblDistance.frame.origin.x, self.lblDistance.frame.origin.y, self.lblDistance.frame.size.width, size.height);
    self.lblDistance.text=text;
}


- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSString *getImageURLs = warningEntity.ImagesList;
    arrayURL = [getImageURLs componentsSeparatedByString:@"|"];
    
    NSInteger count = arrayURL.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = arrayURL[i];
        if ([url rangeOfString:@".png"].location !=NSNotFound) {
            url = [url stringByReplacingOccurrencesOfString:@".png" withString:@"_b.jpg"];
        }
        else if ([url rangeOfString:@".jpg"].location !=NSNotFound && [url rangeOfString:@"_b.jpg"].location !=NSNotFound) {
            url = [url stringByReplacingOccurrencesOfString:@".jpg" withString:@"_b.jpg"];
        }
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //photo.srcImageView = self.scrollView.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}



- (void)loadMapsData
{
    @try {
        
        NSString *getLat = nil;
        NSString *getLng = nil;
        NSString *getCity = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults)
        {
            getLat = [defaults objectForKey:@"cloudin_365paxy_lat"];
            getLng = [defaults objectForKey:@"cloudin_365paxy_lng"];
            getCity = [defaults objectForKey:@"cloudin_365paxy_city"];
        }
        
        if (getLat==nil) {
            getLat = [NSString stringWithFormat:@"%@",DefaultLat];
        }
        else{
            getLat =[ NSString stringWithFormat:@"%@",getLat];
        }
        
        if (getLng==nil) {
            getLng = [NSString stringWithFormat:@"%@",DefaultLng];
        }
        else{
            getLng =[ NSString stringWithFormat:@"%@",getLng];
        }
        
        CLLocationCoordinate2D center = {[getLat floatValue],[getLng floatValue]};
        
        /*
        //添加自定义Annotation
        CLLocationCoordinate2D center = {[getLat floatValue],[getLng floatValue]};
      
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = center;
        annotation.title    = warningEntity.SafeAddress;
        annotation.subtitle = warningEntity.SafeTitle;
        
        [self.mapView addAnnotation:annotation];
        [self.mapView setCenterCoordinate:center animated:YES];*/
        
        self.annotations = [NSMutableArray array];
        
        /* Red annotation. */
        MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
        red.coordinate = center;
        red.title      =  warningEntity.SafeAddress;
        [self.annotations insertObject:red atIndex:AnnotationViewControllerAnnotationTypeRed];

        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
}

- (IBAction) btnMapPressed: (id) sender
{
    
    WarningMapViewController *vc = [[WarningMapViewController alloc] init];
    vc.setLat = warningEntity.SafeLat;
    vc.setLng = warningEntity.SafeLng;
    vc.setAddress = warningEntity.SafeAddress;
    [self.navigationController pushViewController:vc animated:YES];
}

//关闭、返回页面
- (void)closeView
{
    //self.navigationController.navigationBarHidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES]; //back
}




//更新访问量
- (void)updateWarningClickNum
{
    @try {
        
        NSString *getUserID = nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (defaults){
            getUserID = [defaults objectForKey:@"cloudin_365paxy_uid"];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&wid=%@&uid=%@",WarningVisitUrl,warningEntity.SafeID,getUserID];
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
     
            NSLog(@"Visit Status=%@",getStatus);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
}

//删除安全警示台信息
- (void)delData
{
    @try {
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@?platform=iOS&wid=%@",WarningDelUrl,warningEntity.SafeID];
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
            
            NSLog(@"Visit Status=%@",getStatus);
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"2" forKey:@"cloudin_365paxy_message_warning"];
            
            [self closeView];
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
