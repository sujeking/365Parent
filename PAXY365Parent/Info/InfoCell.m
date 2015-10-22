//
//  InfoCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/7/13.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "InfoCell.h"

#import "NewsEntity.h"
#import "Common.h"
#import "UIColor+Hex.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface InfoCell ()

@end

@implementation InfoCell
@synthesize lblTitle;
@synthesize lblDesc;
@synthesize lblVisitNum;
@synthesize newsImage;
@synthesize activityIndicator;
@synthesize lblDate;

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    //lblBGColor.backgroundColor = SubBgColor;
    
    if ([object isKindOfClass:[NewsEntity class]])
    {
        NewsEntity *data = (NewsEntity *)object;
        
        // 设置标题
        lblTitle.text = data.newsTitle;
        if (data.titleColor.length == 0 || data.titleColor == nil) {
            lblTitle.textColor = TxtBlack;
        } else {
            lblTitle.textColor = [UIColor colorWithHexString:data.titleColor];
        }
        
        if ([data.titleB isEqualToString:@"1"]) {
            lblTitle.font = [UIFont boldSystemFontOfSize:15];
        }else {
            lblTitle.font = [UIFont systemFontOfSize:15];
        }
        
        lblVisitNum.text = [NSString stringWithFormat:@"浏览：%@",data.visitNum];
        lblVisitNum.textColor = TxtGray;
        
        NSString *getDesc =  data.newsDesc;
        getDesc = [getDesc stringByReplacingOccurrencesOfString:@" " withString:@""];
        lblDesc.text = getDesc;
        lblDesc.textColor = TxtGray;
        
        NSString *getDate = data.addDate;
        if ([getDate isEqualToString:@"1"]) {
            //隐藏日期
            lblDate.hidden = TRUE;
            //lblTitle.frame = CGRectMake(8, 12, 320, 17);

        }
        else{
            lblDate.hidden = FALSE;
            lblDate.text = [NSString stringWithFormat:@"%@",data.showDate];
            lblDate.textColor = TxtBlue;
          //  lblDate.backgroundColor = TxtBlue;
            //lblTitle.frame = CGRectMake(8, 12, 240, 17);
        }
  
        
        NSString *getHeadImageURL = data.newsImage;
        if ([getHeadImageURL rangeOfString:@".png"].location !=NSNotFound) {
            getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".png" withString:@"_s.jpg"];
        }
        else if ([getHeadImageURL rangeOfString:@".jpg"].location !=NSNotFound) {
            getHeadImageURL = [getHeadImageURL stringByReplacingOccurrencesOfString:@".jpg" withString:@"_s.jpg"];
        }
        [self.newsImage setImageWithURL:[NSURL URLWithString:getHeadImageURL]
                       placeholderImage:[UIImage imageNamed:@"default_image_90_70.png"] options:SDWebImageProgressiveDownload
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   //加载图片及指示器效果
                                   if (!activityIndicator) {
                                       [newsImage addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
                                       activityIndicator.center = CGPointMake(10, 20);
                                       //[activityIndicator startAnimating];//有BUG，不会出现在正中间，而且偶尔转的不会停止
                                   }
                               } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                   //清除指示器效果
                                   [activityIndicator removeFromSuperview];
                                   activityIndicator = nil;
                               }];
         // newsImage.contentMode = UIViewContentModeScaleAspectFill;
        newsImage.layer.masksToBounds = YES;
        newsImage.layer.cornerRadius = 5.0;
        
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
