//
//  GeocodeDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BMapKit.h"
#import "GPRoundView.h"


@interface GeocodeDemoViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate,MBProgressHUDDelegate> {
    
    MBProgressHUD *HUD;
    
	IBOutlet BMKMapView* _mapView;
	IBOutlet UITextField* _coordinateXText;
	IBOutlet UITextField* _coordinateYText;
	IBOutlet UITextField* _cityText;
	IBOutlet UITextField* _addrText;
	BMKGeoCodeSearch* _geocodesearch;
    BMKLocationService *_locService;
     BOOL showUserLocation;
    
    NSString *setTitle;
    NSString *setType;
    
    //加载进度条
    GPRoundView *loadingView;
}

@property (nonatomic,retain) NSString *setTitle;
@property (nonatomic,retain) NSString *setType;


@end
