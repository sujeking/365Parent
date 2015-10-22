//
//  NoticeCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/8/25.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "NoticeCell.h"

#import "MessageEntity.h"
#import "Common.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface NoticeCell ()

@end

@implementation NoticeCell
@synthesize lblTitle;
@synthesize lblCourse;
@synthesize lblDesc;
@synthesize headImage;
@synthesize cameraImage;
@synthesize activityIndicator;
@synthesize lblDate;
@synthesize lblShowDate;
@synthesize lblStatus;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    //lblBGColor.backgroundColor = SubBgColor;
    
    if ([object isKindOfClass:[MessageEntity class]])
    {
        MessageEntity *data = (MessageEntity *)object;
        
        lblTitle.text = data.MessageTitle;
        lblTitle.textColor = TxtBlack;
        
        lblCourse.text = [NSString stringWithFormat:@"%@",data.CourseName];
        lblCourse.textColor = TxtGray;
        lblCourse.hidden = TRUE;
        
        NSString *getDesc =  data.MessageContent;
        lblDesc.text = getDesc;
        lblDesc.textColor = TxtGray;
        
        //签收状态
        lblStatus.text = data.MessageStatus;
        lblStatus.textColor = TxtWhite;
        lblStatus.backgroundColor = TxtYellow;
        lblStatus.hidden = TRUE;
        
        //获得当前cell高度
        CGRect frame = [self frame];
        //文本赋值
        self.lblDesc.text = getDesc;
        //设置label的最大行数
        self.lblDesc.numberOfLines = 10;
        CGSize size = CGSizeMake(300, 1000);
        CGSize labelSize = [self.lblDesc.text sizeWithFont:self.lblDesc.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
        self.lblDesc.frame = CGRectMake(self.lblDesc.frame.origin.x, self.lblDesc.frame.origin.y, labelSize.width, labelSize.height);
        
        //计算出自适应的高度
        frame.size.height = labelSize.height+100;
        
        self.frame = frame;
        
        
        NSString *getCameraImage = data.MessageImage;
        if (getCameraImage.length>0) {
            cameraImage.hidden = FALSE;
        }
        else{
            cameraImage.hidden = TRUE;
        }
        
        //日期处理
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
        
        //头像
        NSString *getHeadImageURL = data.SendUserImage;
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
