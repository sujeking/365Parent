//
//  TestMapViewController.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-03-15
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "TestMapViewController.h"

@interface TestMapViewController ()

@end

@implementation TestMapViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.showsUserLocation = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mapView = [[MAMapView alloc] init];
    self.mapView.delegate = self;
    //[self.view addSubview:self.mapView];
    //self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实时获取定位的经纬度
-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation
updatingLocation:(BOOL)updatingLocation
{
    NSNumber *getLat =[NSNumber numberWithDouble:userLocation.location.coordinate.latitude];
    NSNumber *getLng =[NSNumber numberWithDouble:userLocation.location.coordinate.longitude];
    NSLog(@"lat=%@,lng=%@",getLat,getLng);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:getLat forKey:@"cloudin_365paxy_lat"];
    [defaults setObject:getLng forKey:@"cloudin_365paxy_lng"];
}

//定位失败时抛出消息
-(void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error
{
    NSLog(@"location error=%@",[NSString stringWithFormat:@"%@",error]);
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
