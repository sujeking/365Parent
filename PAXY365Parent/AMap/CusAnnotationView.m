//
//  CusAnnotationView.m
//  PAXY365Parent
//
//  Created by Cloudin 2015-03-15
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "CusAnnotationView.h"

#import "CustomCalloutView.h"
#import "EGOImageView.h"
#import "Common.h"

#define kWidth  30.f
#define kHeight 30.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  30.f
#define kPortraitHeight 30.f

#define kCalloutWidth   250.0
#define kCalloutHeight  80.0

@interface CusAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CusAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    //跳转到商户页面
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
    
    NSString *getShopName = [self.annotation title];
    NSString *getContent = [self.annotation subtitle];
    NSArray *splitConent = [getContent componentsSeparatedByString: @"#"];
    NSString *getShopID =  [splitConent objectAtIndex: 0];
    NSString *getShopLat =  [splitConent objectAtIndex: 1];
    NSString *getShopLng =  [splitConent objectAtIndex: 2];
    NSString *getShopAddress =  [splitConent objectAtIndex: 3];
    NSString *getShopDesc = [splitConent objectAtIndex: 4];
    NSString *getShopPhone = [splitConent objectAtIndex: 5];
    NSString *getCommentsNum =  [splitConent objectAtIndex: 6];
    NSString *getShopImage1 = [splitConent objectAtIndex: 8];
    NSString *getShopImage2 = [splitConent objectAtIndex: 9];
    NSString *getShopImage3 = [splitConent objectAtIndex: 10];
    NSString *getShopStar = [splitConent objectAtIndex: 11];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:getShopID forKey:@"cloudin_365paxy_gotoshop_temp_shopid"];
    [defaults setObject:getShopLat forKey:@"cloudin_365paxy_gotoshop_temp_shoplat"];
    [defaults setObject:getShopLng forKey:@"cloudin_365paxy_gotoshop_temp_shoplng"];
    [defaults setObject:getShopAddress forKey:@"cloudin_365paxy_gotoshop_temp_shopaddress"];
    [defaults setObject:getShopDesc forKey:@"cloudin_365paxy_gotoshop_temp_shopdesc"];
    [defaults setObject:getShopPhone forKey:@"cloudin_365paxy_gotoshop_temp_shopphone"];
    [defaults setObject:getCommentsNum forKey:@"cloudin_365paxy_gotoshop_temp_commentsnum"];
    [defaults setObject:getShopImage1 forKey:@"cloudin_365paxy_gotoshop_temp_shopimage1"];
    [defaults setObject:getShopImage2 forKey:@"cloudin_365paxy_gotoshop_temp_shopimage2"];
    [defaults setObject:getShopImage3 forKey:@"cloudin_365paxy_gotoshop_temp_shopimage3"];
    [defaults setObject:getShopStar forKey:@"cloudin_365paxy_gotoshop_temp_shopstar"];
    [defaults setObject:getShopName forKey:@"cloudin_365paxy_gotoshop_temp_shopname"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cloudin_365paxy_gotoshop" object:@"1"];
   
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            //获取值
            NSString *getShopName = [self.annotation title];
            NSString *getContent = [self.annotation subtitle];
            NSArray *splitConent = [getContent componentsSeparatedByString: @"#"];
            
            //NSString *getContent =[NSString stringWithFormat:@"%@#%@#%@#%@#%@#%@#%@#%@#%@#",getShopID,getLat,getLng,getAddress,getDesc,getPhone,getCommentsNum,showDistance,getShopImage];
            NSString *getAddress = [splitConent objectAtIndex: 3];
            NSString *getDistance = [NSString stringWithFormat:@"距离%@",[splitConent objectAtIndex: 7]];
            NSString *getImageURL = [splitConent objectAtIndex: 8];
            
            /* Construct custom callout. */
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(10, 8, 200, 80);
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            [self.calloutView addSubview:btn];
            
            EGOImageView *asyncImageView1 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"default_image_upload.png"]];
            asyncImageView1.frame = CGRectMake(10, 10, 50, 50);
            asyncImageView1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",getImageURL]];
            [self.calloutView addSubview:asyncImageView1];
            
            //商户名称
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(65, 8, 150, 21)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor whiteColor];
            name.text = getShopName;
            name.font = [UIFont systemFontOfSize:14.0];
            [self.calloutView addSubview:name];
            //距离
            UILabel *distance = [[UILabel alloc] initWithFrame:CGRectMake(65, 28, 150, 21)];
            distance.backgroundColor = [UIColor clearColor];
            distance.textColor = TxtLightGray;
            distance.text = getDistance;
            distance.font = [UIFont systemFontOfSize:12.0];
            [self.calloutView addSubview:distance];
            //地址
            UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(65, 45, 180, 21)];
            address.backgroundColor = [UIColor clearColor];
            address.textColor = TxtLightGray;
            address.text = getAddress;
            address.font = [UIFont systemFontOfSize:12.0];
            [self.calloutView addSubview:address];
           
        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits, 
     even if they actually lie within one of the receiver’s subviews. 
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        //self.backgroundColor = [UIColor grayColor];
        
        /* Create portrait image view and add to view hierarchy. */
        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHoriMargin, kVertMargin, kPortraitWidth, kPortraitHeight)];
        [self addSubview:self.portraitImageView];
        
        /* Create name label. */
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitWidth + kHoriMargin,
                                                                   kVertMargin,
                                                                   kWidth - kPortraitWidth - kHoriMargin,
                                                                   kHeight - 2 * kVertMargin)];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
        self.nameLabel.textColor        = [UIColor whiteColor];
        self.nameLabel.font             = [UIFont systemFontOfSize:15.f];
        //[self addSubview:self.nameLabel];
    }
    
    return self;
}

@end
