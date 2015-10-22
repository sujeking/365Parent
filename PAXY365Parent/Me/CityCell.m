//
//  CityCell.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-02-10
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "CityCell.h"
#import "CityEntity.h"
#import "Common.h"

@interface CityCell ()

@end

@implementation CityCell
@synthesize lblCityName;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    //lblBGColor.backgroundColor = SubBgColor;
    
    if ([object isKindOfClass:[CityEntity class]])
    {
        CityEntity *data = (CityEntity *)object;
        
        lblCityName.text = data.cityName;
        
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
