//
//  ReGeocodeAnnotation.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-03-15
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ReGeocodeAnnotation.h"

@interface ReGeocodeAnnotation ()

@property (nonatomic, readwrite, strong) AMapReGeocode *reGeocode;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end

@implementation ReGeocodeAnnotation
@synthesize reGeocode  = _reGeocode;
@synthesize coordinate = _coordinate;

#pragma mark - MAAnnotation Protocol

- (NSString *)title
{
    /* 包含 省, 市, 区以及乡镇.  */
    return [NSString stringWithFormat:@"%@%@%@%@",
            self.reGeocode.addressComponent.province,
            self.reGeocode.addressComponent.city,
            self.reGeocode.addressComponent.district,
            self.reGeocode.addressComponent.township];
    
}

- (NSString *)subtitle
{
    /* 包含 社区，建筑. */
    return [NSString stringWithFormat:@"%@%@",
            self.reGeocode.addressComponent.neighborhood,
            self.reGeocode.addressComponent.building];
}

#pragma mark - Life Cycle

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate reGeocode:(AMapReGeocode *)reGeocode
{
    if (self = [super init])
    {
        self.coordinate = coordinate;
        self.reGeocode  = reGeocode;
    }
    
    return self;
}

@end
