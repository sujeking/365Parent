//
//  CityCell.h
//  PAXY365Parent
//
//  Created by Cloudin 2015-02-10
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCustomCell.h"

@interface CityCell : BaseCustomCell
{
    UILabel *lblCityName;
    
}

@property (nonatomic,retain) IBOutlet UILabel *lblCityName;

@end