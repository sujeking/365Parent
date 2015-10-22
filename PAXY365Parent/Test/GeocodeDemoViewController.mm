//
//  GeocodeDemoViewController.mm
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "GeocodeDemoViewController.h"

#import "ShopDetailsViewController.h"
#import "ShopListViewController.h"

#import "CustomPointAnnotation.h"
#import "CallOutAnnotationView.h"
#import "BusPointCell.h"
#import "CalloutMapAnnotation.h"

#import "DataSource.h"
#import "Common.h"
#import "Config.h"
#import "EGOImageView.h"

@interface GeocodeDemoViewController ()
{
    bool isGeoSearch;
     CalloutMapAnnotation *_calloutMapAnnotation;
}
@end

@implementation GeocodeDemoViewController
@synthesize setTitle;
@synthesize setType;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil; // 不用时，置nil
}


//显示弹出消息
-(void)showPopMessage:(NSString *)message
{
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = message;
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:3];
    
    //消息提醒完后，需要清楚历史记录，否则每次都会弹出最后一次遗留
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"cloudin_niceroad_message_map"];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SubBgColor;
    
    //自定义NavgationBar标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(150, 0, 200, 44);
    titleLabel.font = [UIFont systemFontOfSize:20];
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
    
    // 列表
    UIImage *saveImage = [UIImage imageNamed: @"icon_list.png"];
    UIView *containingSaveView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, saveImage.size.width, saveImage.size.height)] autorelease];
    UIButton *saveUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveUIButton setBackgroundImage:saveImage forState:UIControlStateNormal];
    //[saveUIButton setTitle:@"地图" forState:UIControlStateNormal];
    [saveUIButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveUIButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    saveUIButton.frame = CGRectMake(0, 0, saveImage.size.width, saveImage.size.height);
    [saveUIButton addTarget:self action:@selector(gotoList) forControlEvents:UIControlEventTouchUpInside];
    [containingSaveView addSubview:saveUIButton];
    UIBarButtonItem *containingSaveButton = [[[UIBarButtonItem alloc] initWithCustomView:containingSaveView] autorelease];
    self.navigationItem.rightBarButtonItem = containingSaveButton;

    showUserLocation = YES;
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层

	_geocodesearch = [[BMKGeoCodeSearch alloc]init];
    [_mapView setZoomLevel:12];
    
    [self reverseGeocode];
    
    
    //加载数据
    loadingView = [[GPRoundView alloc] initWithFrame:CGRectMake(100, 200, 130, 130)];
    [loadingView starRun];
    [self.view addSubview:loadingView];
}

//关闭、返回页面
- (void)closeView
{
    //self.navigationController.navigationBarHidden = TRUE;
    [self.navigationController popViewControllerAnimated:YES]; //back
}

//列表模式查看
- (void)gotoList{
    
    NSString *getViewStyle = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults){
        getViewStyle = [defaults objectForKey:@"cloudin_niceroad_view_style"];
    }
    
    NSLog(@"view3=%@",getViewStyle);
    
    if ([getViewStyle isEqualToString:@"list"]) {
        //
        [self closeView];
    }
    
    if ([getViewStyle isEqualToString:@"map"]) {
        //
         [defaults setObject:@"image" forKey:@"niceroad_nodata_show_flag"];
         [defaults setObject:@"image" forKey:@"niceroad_nodata_show_sflag"];
         [defaults setObject:@"550" forKey:@"niceroad_nodata_flag"];
         
         ShopListViewController *nextController = [[ShopListViewController alloc] init];
         nextController.setTitle = setTitle;
         nextController.setType = setType;
         [nextController sendGetDatas];
         nextController.hidesBottomBarWhenPushed = YES;
         self.navigationController.navigationBarHidden = FALSE;
         [self.navigationController pushViewController:nextController animated:YES];
         [nextController release];

    }

    
 }



/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    if (showUserLocation) {
        NSLog(@"lat=%f,long=%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        [_mapView updateLocationData:userLocation];
        
         showUserLocation = NO;
    }

}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark
#pragma mark - BMKMapview delegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
    static NSString *annotationIdentifier = @"customAnnotation";
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        
        BMKPinAnnotationView *annotationview = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        
        annotationview.image = [UIImage imageNamed:@"icon_pin.png"];
        //        [annotationview setPinColor:BMKPinAnnotationColorGreen];
        [annotationview setAnimatesDrop:NO];
        annotationview.canShowCallout = NO;
        
        return annotationview;
        
    }
    else if ([annotation isKindOfClass:[CalloutMapAnnotation class]]){
        
        //此时annotation就是我们calloutview的annotation
        CalloutMapAnnotation *ann = (CalloutMapAnnotation*)annotation;
        
        //如果可以重用
        CallOutAnnotationView *calloutannotationview = (CallOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"calloutview"];
        
        //否则创建新的calloutView
        if (!calloutannotationview) {
            calloutannotationview = [[[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"calloutview"] autorelease];
            
            BusPointCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"BusPointCell" owner:self options:nil] objectAtIndex:0];
            
            [calloutannotationview.contentView addSubview:cell];
            calloutannotationview.busInfoView = cell;
        }
        
        //开始设置添加marker时的赋值
        
        //显示商户名称
        calloutannotationview.busInfoView.lblShopName.text = [ann.locationInfo objectForKey:@"ShopName"];
        calloutannotationview.busInfoView.lblShopName.textColor = TxtBlue;
        
        //显示地址
        calloutannotationview.busInfoView.lblAddress.text = [ann.locationInfo objectForKey:@"ShopAddress"];
        calloutannotationview.busInfoView.lblAddress.textColor = TxtGray;
        
        //显示距离
        NSString *getDistance = [ann.locationInfo objectForKey:@"Distance"];
        calloutannotationview.busInfoView.lblDistance.text =[NSString stringWithFormat:@"距离%@",getDistance];
        calloutannotationview.busInfoView.lblDistance.textColor = TxtGray;
        
        //显示图片
        NSString *getImageUrl = [ann.locationInfo objectForKey:@"ShopImage"];
        EGOImageView *asyncImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"default_image_90_90.png"]];
        asyncImageView.frame = CGRectMake(0,0,60,60);
        NSString *imagePath = [NSString stringWithFormat:@"%@",getImageUrl];
        asyncImageView.imageURL = [NSURL URLWithString:imagePath];

        calloutannotationview.busInfoView.imageView.image =  asyncImageView.image;
        
        return calloutannotationview;
        
    }
    
    return nil;
    
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
    NSLog(@"didSelectAnnotationView");
    //CustomPointAnnotation 是自定义的marker标注点，通过这个来得到添加marker时设置的pointCalloutInfo属性
    CustomPointAnnotation *annn = (CustomPointAnnotation*)view.annotation;
    
    
    if ([view.annotation isKindOfClass:[CustomPointAnnotation class]]) {
        
        //如果点到了这个marker点，什么也不做
        if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        //如果当前显示着calloutview，又触发了select方法，删除这个calloutview annotation
        if (_calloutMapAnnotation) {
            [mapView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation=nil;
            
        }
        //创建搭载自定义calloutview的annotation
        _calloutMapAnnotation = [[[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude] autorelease];
        
        //把通过marker(ZNBCPointAnnotation)设置的pointCalloutInfo信息赋值给CalloutMapAnnotation
        _calloutMapAnnotation.locationInfo = annn.pointCalloutInfo;
        
        [mapView addAnnotation:_calloutMapAnnotation];
        
        [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
        
        NSLog(@"111");
    }
    
    
}

// 当点击annotation view弹出的泡泡时，调用此接口
-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    
    NSLog(@"222");
    if (_calloutMapAnnotation&&![view isKindOfClass:[CallOutAnnotationView class]]) {
        
        if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            
            //必须先把值取出来
            NSString *getShopID =  [_calloutMapAnnotation.locationInfo objectForKey:@"ShopID"];
            NSString *getShopName =  [_calloutMapAnnotation.locationInfo objectForKey:@"ShopName"];
            NSString *getShopLat =  [_calloutMapAnnotation.locationInfo objectForKey:@"ShopLat"];
            NSString *getShopLng =  [_calloutMapAnnotation.locationInfo objectForKey:@"ShopLng"];
            NSString *getShopAddress =  [_calloutMapAnnotation.locationInfo objectForKey:@"ShopAddress"];
            NSString *getShopDesc =  [_calloutMapAnnotation.locationInfo objectForKey:@"ShopDesc"];
            NSString *getShopPhone =  [_calloutMapAnnotation.locationInfo objectForKey:@"ShopPhone"];
            NSString *getCommentsNum =  [_calloutMapAnnotation.locationInfo objectForKey:@"CommentsNum"];
            NSString *getShopImage =  [_calloutMapAnnotation.locationInfo objectForKey:@"ShopImage"];
            NSLog(@"%@-%@-%@-%@-%@-%@",getShopID,getShopName,getShopLat,getShopLng,getCommentsNum,getShopAddress);

            //释放页面弹出view
            [mapView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation = nil;

            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"image" forKey:@"niceroad_nodata_show_flag"];
            [defaults setObject:@"image" forKey:@"niceroad_nodata_show_sflag"];
            [defaults setObject:@"550" forKey:@"niceroad_nodata_flag"];

            
            //跳转至商户主页
            ShopDetailsViewController *nextController = [[ShopDetailsViewController alloc] init];
            nextController.setShopID = getShopID;
            nextController.setName = getShopName;
            nextController.setLat = getShopLat;
            nextController.setLng = getShopLng;
            nextController.setAddress = getShopAddress;
            nextController.setPhone = getShopPhone;
            nextController.setDesc = getShopDesc;
            nextController.setCommentsNum = getCommentsNum;
            nextController.setType = @"1";//以后优化
            nextController.setImage = getShopImage;
            nextController.setFlag = @"1";
            nextController.hidesBottomBarWhenPushed = YES;
            self.navigationController.navigationBarHidden = FALSE;
            [self.navigationController pushViewController:nextController animated:YES];
            [nextController release];
            

            
        }
        
        
    }
    
}


- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.location;
		item.title = result.address;
		[_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"正向地理编码";
        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
        [myAlertView release];
		[item release];
	}
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == 0) {
        
        //[self loadMapsData];
        [self performSelectorOnMainThread:@selector(loadMapsData) withObject:nil waitUntilDone:NO];//主线程

	}
}



- (void)reverseGeocode
{
    isGeoSearch = false;
	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){31.199364, 121.478892};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    [reverseGeocodeSearchOption release];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        [self showPopMessage:@"百度地图认证失败"];
        //一般都是KEY弄错了
        NSLog(@"反geo检索发送失败");
    }

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
            getLat = [defaults objectForKey:@"cloudin_niceroad_lat"];
            getLng = [defaults objectForKey:@"cloudin_niceroad_lng"];
            getCity = [defaults objectForKey:@"cloudin_niceroad_city"];
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
        
        if (getCity==nil) {
            getCity = DefaultCity;
        }

        NSString *urlString = [NSString stringWithFormat:@"%@?lat=%@&lng=%@&city=%@&type=%@",ShopListUrl,getLat,getLng,getCity,setType];
        
        //urlString=[urlString stringByReplacingOccurrencesOfString:@"type=1" withString:@"type=0"];
        NSLog(@"URL=%@",urlString);
        urlString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (CFStringRef)urlString,
                                                                        NULL,
                                                                        NULL,
                                                                        kCFStringEncodingUTF8);
        NSDictionary *loginDict = [[DataSource fetchJSON:urlString] retain];
        NSArray *arrayData = [loginDict objectForKey:@"List"];
        NSString *getData = [NSString stringWithFormat:@"%@",arrayData];
        //NSLog(@"array:%@",arrayData);
        if ([getData isEqualToString:@"[]"]) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"1" forKey:@"cloudin_niceroad_message_map"];
            
            [self showPopMessage:@"暂时没有数据"];
        }
        else{
            
            for (int i = 0; i < [arrayData count]; i ++) {
                
                NSDictionary *statusDict = [arrayData objectAtIndex:i];
                NSString *getShopID = [statusDict objectForKey:@"ShopID"];
                NSString *getLat = [statusDict objectForKey:@"ShopLat"];
                NSString *getLng = [statusDict objectForKey:@"ShopLng"];
                NSString *getAddress = [statusDict objectForKey:@"ShopAddress"];
                NSString *getName = [statusDict objectForKey:@"ShopName"];
                NSString *getDesc = [statusDict objectForKey:@"ShopDesc"];
                NSString *getPhone = [statusDict objectForKey:@"ShopPhone"];
                NSString *getCommentsNum = [statusDict objectForKey:@"CommentsNum"];
                NSString *getShopImage = [statusDict objectForKey:@"ShopImage"];
                NSString *getDistance = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"Distance"]];
                NSString *getUnit = [statusDict objectForKey:@"Unit"];
                NSString *showDistance =[NSString stringWithFormat:@"%@%@",getDistance,getUnit];
                //NSLog(@"name=%@,lat=%@,lng=%@",getName,getLat,getLng);
                
                //添加自定义Annotation
                CLLocationCoordinate2D center = {[getLat floatValue],[getLng floatValue]};
                CustomPointAnnotation *pointAnnotation = [[CustomPointAnnotation alloc] init];
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:getShopID,@"ShopID",getLat,@"ShopLat",getLng,@"ShopLng",getAddress,@"ShopAddress",getName,@"ShopName",getDesc,@"ShopDesc",getPhone,@"ShopPhone",getCommentsNum,@"CommentsNum",showDistance,@"Distance",getShopImage,@"ShopImage",nil];
                pointAnnotation.pointCalloutInfo =dict;
                
                pointAnnotation.coordinate = center;
                [_mapView addAnnotation:pointAnnotation];
                [pointAnnotation release];
                
                BMKCoordinateSpan span = {0.04,0.03};
                BMKCoordinateRegion region = {center,span};
                [_mapView setRegion:region animated:NO];
                
                /*
                 CLLocationCoordinate2D pt1 = (CLLocationCoordinate2D){0, 0};
                 pt1 = (CLLocationCoordinate2D){[getLat floatValue], [getLng floatValue]};
                 
                 BMKPointAnnotation* item1 = [[BMKPointAnnotation alloc]init];
                 item1.coordinate = pt1;
                 item1.title = getName;
                 item1.subtitle = [NSString stringWithFormat:@"【距离%@%@】%@",getDistance,getUnit,getAddress];
                 [_mapView addAnnotation:item1];
                 
                 if (i==0) {
                 _mapView.centerCoordinate = pt1;
                 }*/
                
            }

        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return;
    }
    
    [loadingView stopRun];
    
}




- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
    if (_geocodesearch != nil) {
        [_geocodesearch release];
        _geocodesearch = nil;
    }
    if (_mapView) {
        [_mapView release];
        _mapView = nil;
    }
}

@end
