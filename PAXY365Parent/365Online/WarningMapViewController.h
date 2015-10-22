//
//  WarningMapViewController.h
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMapViewController.h"

@interface WarningMapViewController : BaseMapViewController{
    
    
    NSString *setLat;
    NSString *setLng;
    NSString *setAddress;
}

@property (nonatomic,retain) NSString *setLat;
@property (nonatomic,retain) NSString *setLng;
@property (nonatomic,retain) NSString *setAddress;

@end
