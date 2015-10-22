//
//  LeaveCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/20.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "LeaveCell.h"

#import "MessageEntity.h"
#import "Common.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface LeaveCell ()

@end

@implementation LeaveCell
@synthesize lblName;
@synthesize lblCourse;
@synthesize lblDesc;
@synthesize headImage;
@synthesize cameraImage;
@synthesize activityIndicator;
@synthesize lblDate;
@synthesize lblStatus;
@synthesize lblShowDate;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    //lblBGColor.backgroundColor = SubBgColor;
    
    if ([object isKindOfClass:[MessageEntity class]])
    {
        MessageEntity *data = (MessageEntity *)object;
        
        lblName.text = data.AcceptUserName;
        lblName.textColor = TxtBlack;
        
        lblCourse.text = [NSString stringWithFormat:@"%@",data.CourseName];
        lblCourse.textColor = TxtGray;
        lblCourse.hidden = TRUE;
        
        NSString *getDesc =  data.MessageContent;
        lblDesc.text = getDesc;
        lblDesc.textColor = TxtGray;
        
        lblDate.text = data.ShowDate;
        lblDate.textColor = TxtGray;
        NSString *getDate = data.AddDate;
        if ([getDate isEqualToString:@"1"]) {
            //隐藏日期
            lblShowDate.hidden = TRUE;
            //lblTitle.frame = CGRectMake(8, 12, 320, 17);
            
        }
        else{
            lblShowDate.hidden = FALSE;
            lblShowDate.text = [NSString stringWithFormat:@"%@",data.AddDate];
            lblShowDate.textColor = TxtBlack;
            //lblShowDate.backgroundColor = TxtBlue;
            //lblTitle.frame = CGRectMake(8, 12, 240, 17);
        }
        
        NSString *getCameraImage = data.MessageImage;
        if (getCameraImage.length>0) {
            cameraImage.hidden = FALSE;
        }
        else{
            cameraImage.hidden = TRUE;
        }
        
        lblStatus.text = data.MessageStatus;
        lblStatus.textColor = TxtWhite;
        lblStatus.backgroundColor = TxtYellow;
        
        //头像
        NSString *getHeadImageURL = data.AcceptUserImage;
        if ([getHeadImageURL rangeOfString:@".png"].location !=NSNotFound) {
            getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
        }
        else if ([getHeadImageURL rangeOfString:@".jpg"].location !=NSNotFound) {
            getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
        }
        [self.headImage setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                       placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   //加载图片及指示器效果
                                   if (!activityIndicator) {
                                       [headImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                       activityIndicator.center = headImage.center;
                                       [activityIndicator startAnimating];
                                   }
                               } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                   //清除指示器效果
                                   [activityIndicator removeFromSuperview];
                                   activityIndicator = nil;
                               }];
        headImage.layer.masksToBounds = YES;
        headImage.layer.cornerRadius = 5.0;
        
        
        if ([getCameraImage rangeOfString:@".png"].location !=NSNotFound) {
            getCameraImage = [getCameraImage stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
        }
        else if ([getCameraImage rangeOfString:@".jpg"].location !=NSNotFound) {
            getCameraImage = [getCameraImage stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
        }
        [self.cameraImage setImageWithURL:[NSURL URLWithString:getCameraImage]
                         placeholderImage:[UIImage imageNamed:@"default_image_100.png"] options:SDWebImageProgressiveDownload
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                     //加载图片及指示器效果
                                     if (!activityIndicator) {
                                         [cameraImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                         activityIndicator.center = cameraImage.center;
                                         [activityIndicator startAnimating];
                                     }
                                 } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                     //清除指示器效果
                                     [activityIndicator removeFromSuperview];
                                     activityIndicator = nil;
                                 }];
        cameraImage.layer.masksToBounds = YES;
        cameraImage.layer.cornerRadius = 5.0;
        
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
