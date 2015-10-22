//
//  TestMapViewController.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-03-15
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface TestMapViewController : UIViewController<MAMapViewDelegate>{
    
}

@property (nonatomic, strong) MAMapView *mapView;

@end
