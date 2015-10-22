//
//  ContactsCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "ContactsCell.h"

#import "ContactsEntity.h"
#import "Common.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ContactsCell ()

@end

@implementation ContactsCell
@synthesize lblName;
@synthesize activityIndicator;
@synthesize imageView;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    //lblBGColor.backgroundColor = SubBgColor;
    
    if ([object isKindOfClass:[ContactsEntity class]])
    {
        ContactsEntity *data = (ContactsEntity *)object;
        
        lblName.text = [NSString stringWithFormat:@"%@",data.NickName];
        lblName.textColor = TxtLightBlack;

        NSString *getHeadImageURL = data.UserImage;
        if ([getHeadImageURL rangeOfString:@".png"].location !=NSNotFound) {
            getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
        }
        else if ([getHeadImageURL rangeOfString:@".jpg"].location !=NSNotFound) {
            getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
        }
        [self.imageView setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                       placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   //加载图片及指示器效果
                                   if (!activityIndicator) {
                                       [imageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                       activityIndicator.center = imageView.center;
                                       //[activityIndicator startAnimating];//有BUG，不会出现在正中间，而且偶尔转的不会停止
                                   }
                               } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                   //清除指示器效果
                                   [activityIndicator removeFromSuperview];
                                   activityIndicator = nil;
                               }];
        // newsImage.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5.0;
        
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
