//
//  InfoShareCell.m
//  PAXY365Parent
//
//  Created by Knight Lee on 15/9/22.
//  Copyright (c) 2015年 新疆大德小蜜蜂通信技术有限公司 All rights reserved.
//

#import "InfoShareCell.h"
#import "NewsEntity.h"
#import "Common.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface InfoShareCell ()

@end

@implementation InfoShareCell
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
        
        lblTitle.text = data.newsTitle;
        lblTitle.textColor = TxtBlack;
        
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
            lblDate.textColor = TxtWhite;
            lblDate.backgroundColor = TxtBlue;
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

- (IBAction) btnDelPressed: (id) sender
{
    if ([object isKindOfClass:[NewsEntity class]])
    {
        NewsEntity *data = (NewsEntity *)object;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:data.newsId forKey:@"cloudin_365paxy_get_newsid"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cloudin_365paxy_selected_newsid" object:@"1"];
        
        NSLog(@"ID:%@",data.newsId);
    }
}

-(void) dealloc
{
    [super dealloc];
}


@end
