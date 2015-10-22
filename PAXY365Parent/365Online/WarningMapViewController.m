//
//  WarningMapViewController.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "WarningMapViewController.h"

#import "Common.h"

enum {
    AnnotationViewControllerAnnotationTypeRed = 0,
    AnnotationViewControllerAnnotationTypeGreen,
    AnnotationViewControllerAnnotationTypePurple
};

@interface WarningMapViewController ()
@property (nonatomic, strong) NSMutableArray *annotations;
@end

@implementation WarningMapViewController
@synthesize annotations = _annotations;
@synthesize setAddress;
@synthesize setLng;
@synthesize setLat;

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    
    NSString *getLat = setLat;
    NSString *getLng = setLng;
    NSString *getTitle = setAddress;
    
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
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    //titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"地图查看";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
    //返回
    UIImage *logoImage = [UIImage imageNamed: @"icon_back.png"];
    UIView *containingLogoView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, logoImage.size.width, logoImage.size.height)] autorelease];
    UIButton *logoUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoUIButton setImage:logoImage forState:UIControlStateNormal];
    logoUIButton.frame = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
    [logoUIButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [containingLogoView addSubview:logoUIButton];
    UIBarButtonItem *containingLogoButton = [[[UIBarButtonItem alloc] initWithCustomView:containingLogoView] autorelease];
    self.navigationItem.leftBarButtonItem = containingLogoButton;
    
    
    //高德地图定位
    //[[UIScreen mainScreen] currentMode].size.height
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,0,320,568)];
    self.mapView.delegate = self;
    [self.mapView setZoomLevel: 14 animated:YES];
    [self.view addSubview:self.mapView];
    
    [self initAnnotations];
    
    
    float h = [UIScreen mainScreen].bounds.size.height;
    
    //固定底部VIEW
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, h - 50, 320, 50)];
    bottomView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.8];
    [self.view addSubview:bottomView];
    
    UILabel *lblAddress =[[UILabel alloc] initWithFrame: CGRectMake(0, 5, 320, 45)];
    lblAddress.text = setAddress;
    lblAddress.numberOfLines = 2;
    lblAddress.font = [UIFont systemFontOfSize:15.0];
    lblAddress.textAlignment = NSTextAlignmentCenter;
    lblAddress.textColor = TxtBlack;
    [bottomView addSubview:lblAddress];
}


//返回页面
- (void)backView
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{
    //
    //}];
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
